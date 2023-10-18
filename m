Return-Path: <linux-fsdevel+bounces-663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205CD7CE119
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E916B2122B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 15:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E84238FB1;
	Wed, 18 Oct 2023 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ7reMol"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1403D15AE2
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 15:24:24 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57C194;
	Wed, 18 Oct 2023 08:24:23 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66d264e67d8so29394306d6.1;
        Wed, 18 Oct 2023 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697642663; x=1698247463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deVo9qsmLU9IzO8fZiwxHWP5rj9qLKYcMtfG735bfDs=;
        b=eQ7reMolXvE1Dfvz2JTMzh8AQMDCznIozMIWfyifPUTxGg+5Hw/JbrcVZup4zkO4Li
         /3s3sx0ij6nqYe8MurikSvJAnamfZYPl4dlSS7/wrla9sshxKmj2li7EboLaZxhxpMd2
         9SHsDaJsd/cdc00DZbe+GOgyUqokNgje1y3p2haIewJJVgrD6QiVN4daalEh1CxqL9Ch
         u++JB4/Ps4UWn1f2AY58m/O2DwvCQ0LE8RAEFMOXMAvc64mVCkLufpVBZP0Pg3h7EeB4
         ChCyk+dzP/sFznUu99Rl2WsL9T6augpP3aeoy0Ra4NlCYgO/+2LKXnHyM9H/kjxmbthw
         Sfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697642663; x=1698247463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deVo9qsmLU9IzO8fZiwxHWP5rj9qLKYcMtfG735bfDs=;
        b=dEKnc1iIQxnv0SL53oD+YHGBunS7uYArMNzHg62QrLfCOqEEOS2nuBrFAnK3exG4hn
         5f7o1dMCrGLqLQvjG0dy2eBXEyhqvQ2RogICEnubHMIY/B0ChZVPA/1ltK8+VQ9qHJ+D
         GxNrxilo4gLdV6dT2caRI0Lx/Pa+RAG0f+KkdM+Lqvp/VUfqILkguCkg10kAnmaCT9gs
         q3he22dgsYC1qLwV3mWWT4Oeuu/0+7x8Rskz8pPS5WYUCQHKlhxr/iBQXSniLrlua4ES
         M9GHFZheHja1E4v51uKcxWizSfis377Wey+947hpjnOTLPLvmelzMw1xT19KNg9O4MOc
         9z3g==
X-Gm-Message-State: AOJu0Yyy29zGaAzEIHmiIZ/ENI/gyPousS5Xq+UShVvE4F9qB06OdX06
	HZwx7PADHBZDnhdiDAdBqtp9qNKsdbmeYddIL6A=
X-Google-Smtp-Source: AGHT+IFN/hVwW/3QoomjE0hDF9Xf33LD8uHLikL3lRvcW+lCSwYE1cF6LELRm7ufppDQdw1X+O7xbSVNp2nER1AKnIE=
X-Received: by 2002:a05:6214:5089:b0:66d:f75:bd1a with SMTP id
 kk9-20020a056214508900b0066d0f75bd1amr5037178qvb.65.1697642662696; Wed, 18
 Oct 2023 08:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018100000.2453965-1-amir73il@gmail.com> <20231018100000.2453965-4-amir73il@gmail.com>
 <b873e5f40babe559bd53fd730d13b358066942fa.camel@kernel.org> <f8fa68ec-e841-4187-a611-142f06c19e25@oracle.com>
In-Reply-To: <f8fa68ec-e841-4187-a611-142f06c19e25@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 18 Oct 2023 18:24:11 +0300
Message-ID: <CAOQ4uxjzXT-x1+LRH80K9Ss7mrjMkePbjTjUmgbpDQXP4jhFgQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] exportfs: make ->encode_fh() a mandatory method for
 NFS export
To: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>, 
	Salah Triki <salah.triki@gmail.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
	Anton Altaparmakov <anton@tuxera.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Steve French <sfrench@samba.org>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Evgeniy Dushistov <dushistov@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 5:53=E2=80=AFPM Dave Kleikamp <dave.kleikamp@oracle=
.com> wrote:
>
> On 10/18/23 9:16AM, Jeff Layton wrote:
> > On Wed, 2023-10-18 at 12:59 +0300, Amir Goldstein wrote:
> >> export_operations ->encode_fh() no longer has a default implementation=
 to
> >> encode FILEID_INO32_GEN* file handles.
> >>
> >> Rename the default helper for encoding FILEID_INO32_GEN* file handles =
to
> >> generic_encode_ino32_fh() and convert the filesystems that used the
> >> default implementation to use the generic helper explicitly.
>
> Isn't it possible for some of these filesystems to be compiled without
> CONFIG_EXPORTFS set? Should exportfs.h define an null
> generic_encode_ino32_fh() in that case?
>

Yes, good idea!

Thanks,
Amir.

