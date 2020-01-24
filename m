Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A593914781F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 06:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgAXF16 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 00:27:58 -0500
Received: from sonic303-23.consmr.mail.gq1.yahoo.com ([98.137.64.204]:41694
        "EHLO sonic303-23.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727520AbgAXF16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 00:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1579843676; bh=9necSZIJYyRRJ8jaU0pxv6QHcZkJLNsfLRyto+nrVh0=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=WwEBKWsy3oq7a8PjwdUA//IN9YkACLmL5JznGU9u2ynO50qVQKTY+sGwdeM7JCgEqxq4e4P5wPDriPFV5J79Ssf3kl73HUHggdKPFI+v28aGyt+jmBW7h/T7+8YfdjfuUI8/myIw1/Ztm0RBiCtqK9HV8IYngEvGsMoEEnwKWLwdOjb6iBo9i6wgrVr457ybo9zDHNQ1daEoGg1E1MjmeyNuEM5eNjG3Bq60L0MRPzy05DtHXZkUcAeY9LeNU/cwL4sJE+J5e9ytGu1sKX2xYKkJuVVM9bpsc5oditlBs85xcTX6bi9KBEJ2yY2XPHN24XV46BZLJFrAD+yY8+AjgA==
X-YMail-OSG: qwkSMKYVM1nerF17bL_ncoKZ2f_7EvelyTnyy3.ARwKl_O4amY4btNkvurM6GkS
 tz_M1Jj66QgrapfINFE7UFlEbiLNWpxMMC0irIKqVtR4VgNCfNvkd2GitLYcrbCEmRe__rz9aEDG
 ZfHMAOJOxx8fZ6DX9H0vybNj_il3xFVv7olWcc976yMVozTOQdrl9J8EmFPPy4uUXGR8aJNwQjbP
 U0jJFJDZItheE38vAa3kAOdwUJzSRNztxYZIVgkvclBGwRBEHp_2tN7swPgkkgpcM1RHu7Ar0nM1
 zCyuJZxodiGH0E6xnDscrLD5EybnjK5gxz_mv8_Dc_gtUlE6.IhtxeaDuoD.lVe_7enHdDvyZpVA
 Fm6oZEn7vQTuCO8pj9Zd1rM7wU5BVpa7v0iDmjHZxOVvrnhXwrMWqkyZJurCYT5IZG_Pwg.u8tkx
 1SIUkcsDBLAI0u8Jj03SLeMwfB.cfPkxTUKOS8rrzMl.iVDp2HFup9VnvedaUEqwUaGqyIImdzm3
 9YQvtEyumMbr7Hg.gHWnwE67kU7wpQm9nbxIE_l.CjFarf4wu12imoWhbtFQpj2ltbeLIK7qu3Fd
 6yOudhzS1S3pavDFunOHu9UXRtoXrKEglCQhA3YR1NAVrHmOr8CzPHPMxd3DWdzy7S3gRnDpG_AX
 gk2c3R.D54fyXcrsNuWRsGpAL1aa1VGy77HIT1mAfFY0MSeqv1B5eTq7EJFWUSIMTD7tOgh4vBDK
 BNZ1oD5enzzGfKh_1JjuDf69PFMWYbH.QfVWY61YOWdBzSS0uaLHBOXbwzW5rV1XkQKi4j1zmX.l
 10Fk3AeDnoQaWx5Moqv18Oz1Tc..AEiBaD9aTGQfVX7YUyi7jHRovnVy8mAD2F4bQKE5.3nAx427
 uF3LPxI_gkd8LkauPvDyh7HD7SmoZtTubyPxMtgueBIA4YNqGDL8J6IFOMdlNO7jE1WcKDTLE63W
 Uy16LO2Vogu2th1yjnnGpaAhHbjMySKUq3u0u4.HNtd5cg0OuHjjFe0E5YgVM3tI825GTG5bsVOm
 A2H1FYmGq3JdexnGbqGnTfdPOZi4h6DPLHT3Fvxg46yJvXW193JJf69qKG2KdnjnVPYe3396Y13D
 FW6pqj9hNUKu6w_oGAPTBVbEYT2yNXr4.wg1PnYpFHUPDKarAClWCOAmxzlwTCOLK0GuNiWK9ItM
 nNzEWorDfEZi_7RGLuUbFWKb2DKSEaYMBJhg4wqyaK8Ii1GeCkOqWePBwMZieIyKILpHQX3GegwY
 5fPch8JKIXEepoGK7Ud4WkupjyMgzkE8Pe3XRIuVL3slJZMH8RR9urgW831I17RP2Xyx0gBSALJS
 bfVsd3XrV2xpw4O5RqUj16Y76vzS3DemXYXClYZ5yRxjlpIHmk7ctla4tZwODvVmAy.dJKizhsV1
 SdNFR_yBYcwpZQ3UEzU3kojQlAqDMgkk1Ag--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Fri, 24 Jan 2020 05:27:56 +0000
Received: by smtp428.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f9b7953f40d5a7531fce28ad55186da6;
          Fri, 24 Jan 2020 05:27:55 +0000 (UTC)
Date:   Fri, 24 Jan 2020 13:27:50 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH] ext4: fix race conditions in ->d_compare() and ->d_hash()
Message-ID: <20200124052740.GB31271@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200124041234.159740-1-ebiggers@kernel.org>
 <20200124050423.GA31271@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200124051601.GB832@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124051601.GB832@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 09:16:01PM -0800, Eric Biggers wrote:
> On Fri, Jan 24, 2020 at 01:04:25PM +0800, Gao Xiang wrote:
> > > diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> > > index 8964778aabefb..0129d14629881 100644
> > > --- a/fs/ext4/dir.c
> > > +++ b/fs/ext4/dir.c
> > > @@ -671,9 +671,11 @@ static int ext4_d_compare(const struct dentry *dentry, unsigned int len,
> > >  			  const char *str, const struct qstr *name)
> > >  {
> > >  	struct qstr qstr = {.name = str, .len = len };
> > > -	struct inode *inode = dentry->d_parent->d_inode;
> > > +	const struct dentry *parent = READ_ONCE(dentry->d_parent);
> > 
> > I'm not sure if we really need READ_ONCE d_parent here (p.s. d_parent
> > won't be NULL anyway), and d_seq will guard all its validity. If I'm
> > wrong, correct me kindly...
> > 
> > Otherwise, it looks good to me...
> > Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> > 
> 
> While d_parent can't be set to NULL, it can still be changed concurrently.
> So we need READ_ONCE() to ensure that a consistent value is used.

If I understand correctly, unlazy RCU->ref-walk will be guarded by
seqlock, and for ref-walk we have d_lock (and even parent lock)
in relative paths. So I prematurely think no race of renaming or
unlinking evenually.

I'm curious about that if experts could correct me about this.

Thanks,
Gao Xiang

> 
> - Eric
