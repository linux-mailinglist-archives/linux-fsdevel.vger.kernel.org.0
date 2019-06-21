Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED4374E8B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 15:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFUNQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 09:16:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46964 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfFUNQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:16:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so6511892wrw.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2019 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=mPUnKUErQwOwXGwZBT5Ey56iJmCW0WfZLXR1krZvrYU=;
        b=fD9bJpf/v260yqw6OCPl1c6n2YVUF0/+/KN9FwDYvuyHsOQBVQq1DBZjeuryVlfcBL
         RsWyvBi2ngVB5Bz4O9OFKhDgrMYtWSb8sXoKxPeAyQpjI8bmS7oX7Mwiuf1BSNFJz1YW
         noP8uwIdfxl4GC1SIAl5z3/2CrOQVXQ0Zt3cDqK2CG4Tra+hjpUhdJxRRwoMpIQ8w15g
         sa78XKp20dDfNHM5QcIPAB37+UIm3Oq5G3edOMxMqul/E+yQdk/9c1OKB93I3DO4lth1
         L2KkxAkYN2msyRPNWVguqDaOpKXJwT+S9KmRsweiuWd7SqtSLS0l2bqMp0wdPgNnofuq
         3YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=mPUnKUErQwOwXGwZBT5Ey56iJmCW0WfZLXR1krZvrYU=;
        b=kmGBwWnxSXad5Ah3LhGfpQNGMbpHQa473HVIOCyHzf1ja+Er14B2tbwegQPWu0GpAT
         L+gDr+WcOFtq7UEkPBBqZoZWJ4xo83hiTQ9nE9PJmXaNyOArSg8JYaPHE6lIat4hOUFv
         EzHDIh6VPRG2lJrCMzg8ETsIUdBGp9L+j11Z/Vev+sQ18PkpPiGX/oTqCHE18L9C2FeW
         Z4qFxsVlXEEeW5poTEERXYNCUDiU258mMAP4mpGJw0unNLVdAN9lDeMHJrrZVvXX7RB6
         toy1ZGViWSpozw01m9xBTPtaTYtsQh+fee1YPBMO8UoG7XTDfRSG6Jwko86XoyW0finP
         XFCw==
X-Gm-Message-State: APjAAAV+9jxeh2gbF791OBIgOWJn62o2QzrQ3h6d6XwKCKbcfplIRVIg
        XOmlGE2vgZm9krwOy5iVF78XBQ==
X-Google-Smtp-Source: APXvYqyY/SkUhuw7VmjzjNPeIV0bd+A0X6khk42a4daELIRF/NW12Xrlr++mVLsuuQ0AHummNggz+g==
X-Received: by 2002:a5d:484e:: with SMTP id n14mr11788420wrs.348.1561122968459;
        Fri, 21 Jun 2019 06:16:08 -0700 (PDT)
Received: from HUAWEI-nova-2-351a175292c.fritz.box ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id a7sm2668821wrs.94.2019.06.21.06.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:16:07 -0700 (PDT)
Date:   Fri, 21 Jun 2019 15:16:04 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <21652.1561122763@warthog.procyon.org.uk>
References: <20190621094757.zijugn6cfulmchnf@brauner.io> <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk> <155905627927.1662.13276277442207649583.stgit@warthog.procyon.org.uk> <21652.1561122763@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 02/25] vfs: Allow fsinfo() to query what's in an fs_context [ver #13]
To:     David Howells <dhowells@redhat.com>
CC:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
From:   Christian Brauner <christian@brauner.io>
Message-ID: <E76F5188-CED8-4472-9136-BDCDFDAF57F0@brauner.io>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On June 21, 2019 3:12:43 PM GMT+02:00, David Howells <dhowells@redhat=2Ecom=
> wrote:
>Christian Brauner <christian@brauner=2Eio> wrote:
>
>> >  static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_kparams
>*params)
>> >  {
>> >  	struct fd f =3D fdget_raw(fd);
>>=20
>> You're using fdget_raw() which means you want to allow O_PATH fds but
>> below you're checking whether the f_ops correspond to
>> fscontext_fops=2E If it's an O_PATH
>
>It can't be=2E  The only way to get an fs_context fd is from fsopen() or
>fspick() - neither of which allow O_PATH to be specified=2E
>
>If you tried to go through /proc/pid/fd with open(O_PATH), I think
>you'd get
>the symlink, not the target=2E

Then you should use fdget(), no? :)

Christian

