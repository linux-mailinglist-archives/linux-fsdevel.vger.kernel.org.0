Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57C9D14787C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 07:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgAXGPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 01:15:41 -0500
Received: from sonic304-23.consmr.mail.gq1.yahoo.com ([98.137.68.204]:45832
        "EHLO sonic304-23.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730338AbgAXGPk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 01:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1579846539; bh=rzOCOg+HRigNJBDCSh5M7t66n+4i+nmXOEYhY7A53/0=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=plqGOK85gxvVU3WibXDAxN1JCHUtW8XwiCcIfvkAK7oJxWv6p314ypwr4qN4is4I77AlkEx6rAnC5+DYcN/UfGQ4wzZXG05vg0jqUVwOYWfExVzZ3a5DhPfhvvha/dZrMe1bVMlctDLQhmmTan2L13zkyK/Xd71SrAWLt2XpaUOTeWZ8Pz7S3Yi7NfSvZf34SVPHNa0HHqKIlpgtsfs2fLo4tYO6njNWsyPFTVPu08Orel6v2947oV/TvIxAXU1xyqSJ8vDFun+M7XBY5klKs5Nojp0ze/vk9wIlqjw/3PQ0RoQB7NgP9hpSos/ukSdq39Rwew9LuRSNs0M3BgUiPQ==
X-YMail-OSG: bP37ufMVM1mMZYt00lSI0ymT8.nJPkIHnOsGpQbIwPLA5LvMIUyrAr6Wx9RSn5b
 bTkmMYyiErGrtyPZdiJYszIoFCnfKfWpJqOECKwJnFrK7b5H0vmoyGTuH.xwU5AvHM2pNaIOVAGf
 mIAMywHwHA0ocExl9sEn3Wizgx84ApqJ_Y1UuHLFY0AefHRis4SWzxvGH61a6pHHD5.1sZLXzXGP
 10wZBb4L_HvMj5EuVVHH9m5KVYNniExYlTrK6O.CJu3hepG4bkupE0j7QdxsYmF7oJ26NuB.KB.n
 kUepKigdJvLXhyPfpyqD9y3zN1K5ElHEknBApWg2kIH1xwtsYBIoGqYYODi8GCcNCnu1g.rtVqeW
 3BEg0SH_IDubeUup9Gvo1niDn5e8reha_tTUOEaLqof1_aDed48R5w0LN_JxKQsi2kV8s7vz4uey
 f0871FX2tSmq_vyRmfJFQM.yRVgqL8Bfy258ooMWfcrSSPWVcLJ.jchyuXwpjClh1KuwKLuVh8Pi
 S9qaigriFjrTgjYteKrfQCuBf.1ltRpbPnIAnqphCE7QOOyVfurnpK0GsHtQiuYYg7Hcq4Oc2OcY
 wp6J48zuC4AXQbkuhaGs_fsMlFFaTg_arDuSa9uEJkEJqaENK0QbwbMqmFyoupwmk_US_s1Lw.QW
 B8OWEbXNbRwHL9t75VlprRJcMHgwcsie8xFTgE9cnJIk5XHjYun.30aH9kb_YTHpiFP0P47BVotX
 QzfeDPH0p0.l67RyiMDUseC1obugwHGkUNMVrYFN3JsVkWZBsRkUGqiQYHHu2ACzIdt6TGKnNnOs
 RfZcEFWa4iLVIAe7ahx6dytbL4znjapI.gHyokQJq0vDFrNrstEsTgSgytpd0GQCL7ybhpYfr4M1
 29erJnsdPE4DiSG16VOUAMbqblAdBJxN6aj0E9WWI1XEJrrA8IP6rBfya9dLZB0TfNwz7MaCecQK
 lKC8SdiVhkItNUV.bM4lkag5bsMwLtobUGCUMxHO_3xRWFk4WyEsuHwJ01kLAf8tXEzPUJi3oiA8
 pEx8xem1hBZXFA3F4CX.vbszNdZ1NPAmSO74TNXjvYdglN2eia6Nb_z_kRaVuZT.dUIkbs0ymxEt
 .DwCvMEYfW.zF8Msl7ME8q_HyoO0mjtb10c5vsLagembBCl_Z.elpx43yJpbLp_HWjNRYPpLC73E
 ipijNpm0IxlHYtIJv61XfGyn9mZV8sWQ7ucS7vFAa_I0DtSWFythtfD4anizmitCOmwjqm5qgJ90
 uHcNlVUciMjkbAYr0S1lJo0QUiAkFcIQ.F_4r39Vy1FXc535sPxyZskIpJq3KVYvsHjbz4.6pLIQ
 F488l_GrXgZ_frojj57fytKNYGhlFsd7hL2D7r_fbI6Wk6FuzufnLm6.0POFjYC8kjrqh5MG0SXZ
 K
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Fri, 24 Jan 2020 06:15:39 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 72d0469e1612faf085278699e31b4664;
          Fri, 24 Jan 2020 06:15:37 +0000 (UTC)
Date:   Fri, 24 Jan 2020 14:15:31 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH] ext4: fix race conditions in ->d_compare() and ->d_hash()
Message-ID: <20200124061525.GA2407@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200124041234.159740-1-ebiggers@kernel.org>
 <20200124050423.GA31271@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200124051601.GB832@sol.localdomain>
 <20200124053415.GC31271@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200124054256.GC832@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124054256.GC832@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 23, 2020 at 09:42:56PM -0800, Eric Biggers wrote:
> On Fri, Jan 24, 2020 at 01:34:23PM +0800, Gao Xiang wrote:
> > On Thu, Jan 23, 2020 at 09:16:01PM -0800, Eric Biggers wrote:
> > 
> > []
> > 
> > > So we need READ_ONCE() to ensure that a consistent value is used.
> > 
> > By the way, my understanding is all pointer could be accessed
> > atomicly guaranteed by compiler. In my opinion, we generally
> > use READ_ONCE() on pointers for other uses (such as, avoid
> > accessing a variable twice due to compiler optimization and
> > it will break some logic potentially or need some data
> > dependency barrier...)
> > 
> > Thanks,
> > Gao Xiang
> 
> But that *is* why we need READ_ONCE() here.  Without it, there's no guarantee
> that the compiler doesn't load the variable twice.  Please read:
> https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE

After scanning the patch, it seems the parent variable (dentry->d_parent)
only referenced once as below:

-	struct inode *inode = dentry->d_parent->d_inode;
+	const struct dentry *parent = READ_ONCE(dentry->d_parent);
+	const struct inode *inode = READ_ONCE(parent->d_inode);

So I think it is enough as

	const struct inode *inode = READ_ONCE(dentry->d_parent->d_inode);

to access parent inode once to avoid parent inode being accessed
for more time (and all pointers dereference should be in atomic
by compilers) as one reason on

	if (!inode || !IS_CASEFOLDED(inode) || ...

or etc.

Thanks for your web reference, I will look into it. I think there
is no worry about dentry->d_parent here because of this only one
dereference on dentry->d_parent.

You could ignore my words anyway, just my little thought though.
Other part of the patch is ok.

Thanks,
Gao Xiang

> 
> - Eric
