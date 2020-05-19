Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4031D8EF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 07:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgESFC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 01:02:59 -0400
Received: from sender2-of-o52.zoho.com.cn ([163.53.93.247]:21110 "EHLO
        sender2-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbgESFC7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 01:02:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589864507; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=T6L4PqDS956lH8PPR2wGO02Sa8L7usWLMOOgttl8udLpWx12dMsCXZEOCbCEXeXoII+g1hKfHQQWbGbRicyDnMcRmMXrtyRP+yipYScsKs+nkZgkOlaOKNgZxgWlOf2FM5PLA0/zVEK59DseIuTrLRCtTVjk8rEcOeMitxkkQZc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1589864507; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=IAzPyDiMR9Sl5chc9WQJO5sJSmqh1L0xNzsgAR18fG8=; 
        b=LmePfGXi5byzYFZWbeZy2V/ChKNDZR4D/38FkRSYq+wfW6zR2ff6gm497PuQ/KknIAe20639495LsxNtHaH0MOo844LOKT9AduyTMbdRzyGONiAMX5s+QzdTed88IsqM47irqy0MWwMsS1371BziGLju8QK6Kbw8VJSQqJeG878=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589864507;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:Subject:Reply-To:To:Cc:Message-ID:References:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=IAzPyDiMR9Sl5chc9WQJO5sJSmqh1L0xNzsgAR18fG8=;
        b=TYPsw1dcFGXOmSKRcczj3iVUdekoIqFY+cZTnJcbuZ2hUgjEFXHBcgwk8RbneAyx
        Wvs7/T732aV6s6BpgUraeFyky2wJW7NpgBBC+xldMkfcL8RRmq1pxKtcAZjF3BEVq0u
        od5p+ie86iiikgOcON6jUzrQORv16H9sJSO1Uuk4=
Received: from [192.168.166.138] (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1589864504994955.4663756637929; Tue, 19 May 2020 13:01:44 +0800 (CST)
From:   cgxu <cgxu519@mykernel.net>
Subject: Re: [RFC PATCH v3 0/9] Suppress negative dentry
Reply-To: cgxu519@mykernel.net
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, Ian Kent <raven@themaw.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Message-ID: <05e92557-055c-0dea-4fe4-0194606b6c77@mykernel.net>
References: <20200515072047.31454-1-cgxu519@mykernel.net>
 <e994d56ff1357013a85bde7be2e901476f743b83.camel@themaw.net>
 <CAOQ4uxjT8DouPmf1mk1x24X8FcN5peYAqwdr362P4gcW+x15dw@mail.gmail.com>
 <CAJfpegtpi1SVJRbQb8zM0t66WnrjKsPEGEN3qZKRzrZePP06dA@mail.gmail.com>
Date:   Tue, 19 May 2020 13:01:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJfpegtpi1SVJRbQb8zM0t66WnrjKsPEGEN3qZKRzrZePP06dA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=80, 2020-05-18 15:52:48 Miklos Sz=
eredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99=20
----
  > On Mon, May 18, 2020 at 7:27 AM Amir Goldstein <amir73il@gmail.com>=20
wrote:
  > >
  > > On Mon, May 18, 2020 at 3:53 AM Ian Kent <raven@themaw.net> wrote:
  > > >
  > > > On Fri, 2020-05-15 at 15:20 +0800, Chengguang Xu wrote:
  > > > > This series adds a new lookup flag LOOKUP_DONTCACHE_NEGATIVE
  > > > > to indicate to drop negative dentry in slow path of lookup.
  > > > >
  > > > > In overlayfs, negative dentries in upper/lower layers are useless
  > > > > after construction of overlayfs' own dentry, so in order to
  > > > > effectively reclaim those dentries, specify=20
LOOKUP_DONTCACHE_NEGATIVE
  > > > > flag when doing lookup in upper/lower layers.
  > > >
  > > > I've looked at this a couple of times now.
  > > >
  > > > I'm not at all sure of the wisdom of adding a flag to a VFS functio=
n
  > > > that allows circumventing what a file system chooses to do.
  > >
  > > But it is not really a conscious choice is it?
  > > How exactly does a filesystem express its desire to cache a negative
  > > dentry? The documentation of lookup() in vfs.rst makes it clear that
  > > it is not up to the filesystem to make that decision.
  > > The VFS needs to cache the negative dentry on lookup(), so
  > > it can turn it positive on create().
  > > Low level kernel modules that call the VFS lookup() might know
  > > that caching the negative dentry is counter productive.
  > >
  > > >
  > > > I also do really see the need for it because only hashed negative
  > > > dentrys will be retained by the VFS so, if you see a hashed negativ=
e
  > > > dentry then you can cause it to be discarded on release of the last
  > > > reference by dropping it.
  > > >
  > > > So what's different here, why is adding an argument to do that drop
  > > > in the VFS itself needed instead of just doing it in overlayfs?
  > >
  > > That was v1 patch. It was dealing with the possible race of
  > > returned negative dentry becoming positive before dropping it
  > > in an intrusive manner.
  > >
  > > In retrospect, I think this race doesn't matter and there is no
  > > harm in dropping a positive dentry in a race obviously caused by
  > > accessing the underlying layer, which as documented results in
  > > "undefined behavior".
  > >
  > > Miklos, am I missing something?
  >  > Dropping a positive dentry is harmful in case there's a long term
  > reference to the dentry (e.g. an open file) since it will look as if
  > the file was deleted, when in fact it wasn't.
  >  > It's possible to unhash a negative dentry in a safe way if we make
  > sure it cannot become positive.  One way is to grab d_lock and remove
  > it from the hash table only if count is one.
  >  > So yes, we could have a helper to do that instead of the lookup flag=
.
  > The disadvantage being that we'd also be dropping negatives that did
  > not enter the cache because of our lookup.
  >


If we don't consider that only drop negative dentry of our lookup,
it is possible to do like below, isn't it?



diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 723d17744758..fa339e23b0f8 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -200,7 +200,7 @@ static int ovl_lookup_single(struct dentry *base,=20
struct ovl_lookup_data *d,
         int err;
         bool last_element =3D !post[0];

-       this =3D lookup_positive_unlocked(name, base, namelen);
+       this =3D lookup_one_len_unlocked(name, base, namelen);
         if (IS_ERR(this)) {
                 err =3D PTR_ERR(this);
                 this =3D NULL;
@@ -209,6 +209,18 @@ static int ovl_lookup_single(struct dentry *base,=20
struct ovl_lookup_data *d,
                 goto out_err;
         }

+       if (d_flags_negative(this->d_flags)) {
+               inode_lock_shared(base->d_inode);
+               if (d_flags_negative(this->d_flags))
+                       d_drop(this);
+               inode_unlock_shared(base->d_inode);
+
+               dput(this);
+               this =3D NULL;
+               err =3D -ENOENT;
+               goto out;
+       }
+
         if (ovl_dentry_weird(this)) {
                 /* Don't support traversing automounts and other=20
weirdness */
                 err =3D -EREMOTE;


Thanks,
cgxu

