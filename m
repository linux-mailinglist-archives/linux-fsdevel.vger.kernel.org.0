Return-Path: <linux-fsdevel+bounces-2349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D5F7E4F64
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 04:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A7ACB20FD0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 03:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD891373;
	Wed,  8 Nov 2023 03:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CjlSIiQQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634FE1370
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 03:14:35 +0000 (UTC)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3EA10F9
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 19:14:34 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da0344eb3fdso6624818276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Nov 2023 19:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699413274; x=1700018074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5vx1SuH10I5MRrYLP20KitGIgEW4Afe0xq877n9y14=;
        b=CjlSIiQQuOE3VfMJb6D4Vo36nueAem9Rbb01GWWcXrlRqwHLcWpjjXuMeIbOWPRyhG
         H2/yuzBQxt6xla58bQUxpW9dJiUUuQH1uZh2jB/Nw9DwilvMqzko5Pbln09PRGVUcHzJ
         cC1I/zqOwxC+W4DCYVT+w9iGSXbRbzmVMHKFEm0TDZURchgkWVE7KuJPSR5eIOoDNxe2
         DRzYmfmlG7zup3vE+oQk/4h096IC5Cqox/VAgKgQwp9lpMLAFrN3IPphaVDMW+1AZY5p
         PpHtdmgJhyGihHUA8LYlHK8duyBPk4GEwKzA875M6hxBEKhqdSkv+qLwNJ8vQJP3R4dq
         d/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699413274; x=1700018074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5vx1SuH10I5MRrYLP20KitGIgEW4Afe0xq877n9y14=;
        b=A0L/PlkYadCKVs2ymgXD/+1fiFrHhDNp9euV5VeEYFOc/rHUaBACQpOGvRY64DEFXM
         zAty2/E92jqjYvl3sxoqPNmUp3Bodu7enU2aEsRastDAza6Q+IYOILBAPzPAhANEDIIh
         Csd+2RVPEwCOaOQWCh3hZX6v66DmO+e/0Q8E3XJ7pow8Xbgoi1XGOdsVNihTjQa/OpIM
         babBeJ6xQ7PMzwXcO7AbQj5Oa3nvoIeXF1XejxeAp/yjp819iGAHI7pNB18EM0eFovOD
         Jr/PVK/8AuBBBMHX6skHZfCMCNgCfKD1bDhSfTV/BzBAan36H6QX4CqdwLZbAZ16vFbC
         l18g==
X-Gm-Message-State: AOJu0Yx2XVwyqBdRcqrbQoU61HPoGFXxzp9NNQY8dm0LmqsGxP0f4yen
	ihDJf8zoPDLDJkwjDnZcUiWJ82/enMC2CCLv2Dlb
X-Google-Smtp-Source: AGHT+IHRgz90UgPoCYkWlS/aMw9sFfxqMSEFQczpq2CHZMN0KkBg+tCoSKeeUm0SHGN1yPZnqOEZ5u4F1SzXp1qhhSI=
X-Received: by 2002:a25:c00f:0:b0:da0:400e:750c with SMTP id
 c15-20020a25c00f000000b00da0400e750cmr643211ybf.27.1699413274027; Tue, 07 Nov
 2023 19:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com> <563820b8fd57deb99e6247b6cdb416c4c3af3091.camel@huaweicloud.com>
In-Reply-To: <563820b8fd57deb99e6247b6cdb416c4c3af3091.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 7 Nov 2023 22:14:23 -0500
Message-ID: <CAHC9VhQ8otggx3uvwsdK=d6CJ167DHRuqPqihibJ37uCQ=_HbA@mail.gmail.com>
Subject: Re: [PATCH v5 00/23] security: Move IMA and EVM to the LSM infrastructure
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, 
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org, 
	stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, 
	mic@digikod.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 9:06=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> Hi everyone
>
> I kindly ask your support to add the missing reviewed-by/acked-by. I
> summarize what is missing below:
>
> - @Mimi: patches 1, 2, 4, 5, 6, 19, 21, 22, 23 (IMA/EVM-specific
>          patches)
> - @Al/@Christian: patches 10-17 (VFS-specific patches)
> - @Paul: patches 10-23 (VFS-specific patches/new LSM hooks/new LSMs)

This patchset is next in my review queue :)

> - @David Howells/@Jarkko: patch 18 (new LSM hook in the key subsystem)
> - @Chuck Lever: patch 12 (new LSM hook in nfsd/vfs.c)
>
> Paul, as I mentioned I currently based the patch set on lsm/dev-
> staging, which include the following dependencies:
>
> 8f79e425c140 lsm: don't yet account for IMA in LSM_CONFIG_COUNT calculati=
on
> 3c91a124f23d lsm: drop LSM_ID_IMA
>
> I know you wanted to wait until at least rc1 to make lsm/dev. I will
> help for rebasing my patch set, if needed.

No, it should be fine for right now.  Thanks for your patience and
help with all of this.

--=20
paul-moore.com

