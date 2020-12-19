Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF852DEDA6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 08:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgLSHJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 02:09:29 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:53837 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgLSHJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 02:09:29 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 619075802FA;
        Sat, 19 Dec 2020 02:08:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 19 Dec 2020 02:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        LT57GVM4lXJYKuuL/cu3G0owL0h1oeEAn1rAcF9pxpw=; b=td7nfwfOk3JBE/28
        SVRRy/w6DwkEbUVkAnO54rq8kw5ZDeeveUlfjGqU9yC9iGrAH9bwlGLd4T4UP3CL
        7UpiaR1urC0wIQasqrFxaE1BTA7Y/3Vs9a/09OCKcYh4EOTfSM7BETAJitLFNXQd
        W3j/H9IlsfdpB8NZYcn2WSgPSygUSoltqyqGGWy0Ct/+l2qEMJmrVT8WwUpxspP7
        WxuYNvJ6n3yOXjuZ45W+hxYe1dHIqd+VMyYSaVRU1pMTvXhsgjwSDXCn3vIEy02f
        z4jbyD6/CQaNZ71RxLK2neKuaXP7Te0G5UTriE7z9hGWmHIn49s3TNrY6duRPh5Q
        sRJqoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=LT57GVM4lXJYKuuL/cu3G0owL0h1oeEAn1rAcF9px
        pw=; b=kmnXPGRi/7HfNP9J1OVnE+4uRrIJEjTIFE43oZm1KfTqtxlJ1XsZXnGjk
        EXreyZCvc2vrYPALrqzbNfG+mb1beyjAO2TssRGV7LFiAyrlor7xcZjPLrrpPntE
        pXtuuKEk6Jo7EBsGNr4gmfmyGxU2kW45Ez10XOsUC6MvnQt50MQWH/vyKrAE3/8n
        RRTgbk0P2OfK/of//ai3YCNHhC2zE/vTiUV2cl5Gs4COFdRsseZppI8CgiKEyWqr
        NLcBh/ucYF93nHnlxnqMd//Buf5yLxkkKugWz2unujJtzf/5Si+c6cH+JEVq5ZRM
        D6lPhH6FFRVTEJZMI7UE4pwnt59Nw==
X-ME-Sender: <xms:5abdX2lSYdRFc3lY7SKbi0mj1SkQw3ayhMk2zqrRsX72qPVqRbAOIw>
    <xme:5abdX92IPCz230iDajTmg_laeYQCE8QNrRq7tD9bL6NC0Db-tJ9No7LznT_LRwFmc
    _RhBKw75PEq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeljedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddtiedrieelrddvgeejrddvtdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:5abdX0os2QH-ju3yqw16puc5oe9GkGg_sJLBXp32_5AwNoR_n14DCA>
    <xmx:5abdX6nDXSxVEJRcuZCfG3zLsdnTz7Z1S2P_FcDmDo3UcxWz0CX5NQ>
    <xmx:5abdX03pxUvHmyn3vRn09EybOgkoSEZxWbJr-gupTeBYAT19QdefFQ>
    <xmx:5qbdX1kE_oqlSho8d14_JasnQ-xZBrTJHWogynjhibZoodruXY04Fw>
Received: from mickey.themaw.net (106-69-247-205.dyn.iinet.net.au [106.69.247.205])
        by mail.messagingengine.com (Postfix) with ESMTPA id CF0511080059;
        Sat, 19 Dec 2020 02:08:17 -0500 (EST)
Message-ID: <37c339831d4e7f3c6db88fbca80c6c2bd835dff2.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc:     Fox Chen <foxhlchen@gmail.com>, akpm@linux-foundation.org,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        ricklind@linux.vnet.ibm.com, sfr@canb.auug.org.au,
        viro@zeniv.linux.org.uk
Date:   Sat, 19 Dec 2020 15:08:13 +0800
In-Reply-To: <X9zDu15MvJP3NU8K@mtj.duckdns.org>
References: <3e97846b52a46759c414bff855e49b07f0d908fc.camel@themaw.net>
         <CAC2o3DLGtx15cgra3Y92UBdQRBKGckqOkDmwBV-aV-EpUqO5SQ@mail.gmail.com>
         <efb7469c7bad2f6458c9a537b8e3623e7c303c21.camel@themaw.net>
         <da4f730bbbb20c0920599ca5afc316e2c092b7d8.camel@themaw.net>
         <CAC2o3DJsvB6kj=S6D3q+_OBjgez9Q9B5s3-_gjUjaKmb2MkTHQ@mail.gmail.com>
         <c4002127c72c07a00e8ba0fae6b0ebf5ba8e08e7.camel@themaw.net>
         <a39b73a53778094279522f1665be01ce15fb21f4.camel@themaw.net>
         <c8a6c9adc3651e64cf694f580a8cb3d87d7cb893.camel@themaw.net>
         <X9t1xVTZ/ApIvPMg@mtj.duckdns.org>
         <67a3012a6a215001c8be9344aee1c99897ff8b7e.camel@themaw.net>
         <X9zDu15MvJP3NU8K@mtj.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-12-18 at 09:59 -0500, Tejun Heo wrote:
> Hello,
> 
> On Fri, Dec 18, 2020 at 03:36:21PM +0800, Ian Kent wrote:
> > Sounds like your saying it would be ok to add a lock to the
> > attrs structure, am I correct?
> 
> Yeah, adding a lock to attrs is a lot less of a problem and it looks
> like
> it's gonna have to be either that or hashed locks, which might
> actually make
> sense if we're worried about the size of attrs (I don't think we need
> to).

Maybe that isn't needed.

And looking further I see there's a race that kernfs can't do anything
about between kernfs_refresh_inode() and fs/inode.c:update_times().

kernfs could avoid fighting with the VFS to keep the attributes set to
those of the kernfs node by using the inode operation .update_times()
and, if it makes sense, the kernfs node attributes that it wants to be
updated on file system activity could also be updated here.

I can't find any reason why this shouldn't be done but kernfs is
fairly widely used in other kernel subsystems so what does everyone
think of this patch, updated to set kernfs node attributes that
should be updated of course, see comment in the patch?

kernfs: fix attributes update race

From: Ian Kent <raven@themaw.net>

kernfs uses kernfs_refresh_inode() (called from kernfs_iop_getattr()
and kernfs_iop_permission()) to keep the inode attributes set to the
attibutes of the kernfs node.

But there is no way for kernfs to prevent racing with the function
fs/inode.c:update_times().

The better choice is to use the inode operation .update_times() and
just let the VFS use the generic functions for .getattr() and
.permission().

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/inode.c           |   37 ++++++++++++++-----------------------
 fs/kernfs/kernfs-internal.h |    4 +---
 2 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index fc2469a20fed..51780329590c 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -24,9 +24,8 @@ static const struct address_space_operations kernfs_aops = {
 };
 
 static const struct inode_operations kernfs_iops = {
-	.permission	= kernfs_iop_permission,
+	.update_time	= kernfs_update_time,
 	.setattr	= kernfs_iop_setattr,
-	.getattr	= kernfs_iop_getattr,
 	.listxattr	= kernfs_iop_listxattr,
 };
 
@@ -183,18 +182,26 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 		set_nlink(inode, kn->dir.subdirs + 2);
 }
 
-int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
-		       u32 request_mask, unsigned int query_flags)
+static int kernfs_iop_update_time(struct inode *inode, struct timespec64 *time, int flags)
 {
-	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
+	struct kernfs_iattrs *attrs;
 
 	mutex_lock(&kernfs_mutex);
+	attrs = kernfs_iattrs(kn);
+	if (!attrs) {
+		mutex_unlock(&kernfs_mutex);
+		return -ENOMEM;
+	}
+
+	/* Which kernfs node attributes should be updated from
+	 * time?
+	 */
+
 	kernfs_refresh_inode(kn, inode);
 	mutex_unlock(&kernfs_mutex);
 
-	generic_fillattr(inode, stat);
-	return 0;
+	return 0
 }
 
 static void kernfs_init_inode(struct kernfs_node *kn, struct inode *inode)
@@ -272,22 +279,6 @@ void kernfs_evict_inode(struct inode *inode)
 	kernfs_put(kn);
 }
 
-int kernfs_iop_permission(struct inode *inode, int mask)
-{
-	struct kernfs_node *kn;
-
-	if (mask & MAY_NOT_BLOCK)
-		return -ECHILD;
-
-	kn = inode->i_private;
-
-	mutex_lock(&kernfs_mutex);
-	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&kernfs_mutex);
-
-	return generic_permission(inode, mask);
-}
-
 int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
 		     void *value, size_t size)
 {
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 7ee97ef59184..98d08b928f93 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -89,10 +89,8 @@ extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
  */
 extern const struct xattr_handler *kernfs_xattr_handlers[];
 void kernfs_evict_inode(struct inode *inode);
-int kernfs_iop_permission(struct inode *inode, int mask);
+int kernfs_update_time(struct inode *inode, struct timespec64 *time, int flags);
 int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr);
-int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
-		       u32 request_mask, unsigned int query_flags);
 ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size);
 int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
 

