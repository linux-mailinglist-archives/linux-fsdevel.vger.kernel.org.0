Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D293A5D45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 08:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhFNGy6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 02:54:58 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:59269 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232096AbhFNGy6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 02:54:58 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8EC6D580D38;
        Mon, 14 Jun 2021 02:52:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 14 Jun 2021 02:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        a20IbCzPM4YTTKI8ZF8DTTKtgWVXSgMtpkEvyKPJoGU=; b=w0Gs7Bd92ZTiCYm/
        CRtcBD4UD950hXIZeBxLspdXJibcDjcsRCVAZYy0d282bkXnk6wICq/D8eOyDSEL
        KsfoPXNhCPJblnQUAtf82LPbMYmtQRwl65qJqWYTQ19YqSqSShkM2n7B54nLLo2s
        gpP1Aluv6auUhuLeNRoj82RTrZ1MlMGI07SFv6v6+z5vr7QvwNSlhm5I2z07du9p
        HzPyLz2Xa/Z75Q7bs284Ev5nyOEQMufeiQ8pOkIA3Hd+521RsOj1Rpc9axm4D1E/
        q+3+RFCVWkvfVlewA0TozNFqMPf05CY1lydkKZp299wbB7UFyaQ5zzdWQ6Micnsw
        XvCACg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=a20IbCzPM4YTTKI8ZF8DTTKtgWVXSgMtpkEvyKPJo
        GU=; b=Cev5ZchC67MKYxz+78c34Js0HdXg01upS2RQ1NVnittG08hy4zuRWqeWa
        07vsoqsXx/mCPm5PBEiZuYcqVU0ybJfpZQsCoTGW8iDTg28HC8fu3BynQKjyPovr
        /07HQzdDHgtcDZOOwF7r/vTxBpWJSyksEsBZ4lHaIQx7xsVGTfOTkzT9pdEW0czU
        nhJ3u4K1eoOhGEDxObd0fLLFLp+w7WGQgdMgQUyPNbYeUPRhUjqxapihJ9xgdf3D
        UMssnKKEf5G6vM/J1vpiMIXQFP7B3VOJhCgDUoX0tyUBEgyQfN8CKvTbca/peZpD
        h+Q5SpnMearO4pG9PysmyLWMKZp8w==
X-ME-Sender: <xms:xvzGYIRvnmY81A-fnlzTLcN2Ns9eAjMeJ_gS6e81vOEF7llzCtrr-g>
    <xme:xvzGYFwvTJdG_lStcVP2HT9FPQtf6_3GdHha4joD-2QfWo-TMuwZa61BeHgJlsCjy
    TmQyaUWN9Z9>
X-ME-Received: <xmr:xvzGYF0qLUarwgJu5KkTek7VEUOpsBHF0z4aMyp1wdqgIi9b1oD1N45D6nWox-NMBLmcm1cMpk_ZOGGXhL8XbvqX7YwS5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvgedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epgfelleekteehleegheeujeeuudfhueffgfelhefgvedthefhhffhhfdtudfgfeehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:xvzGYMAD6m2atCu6BvBxT6HHEOnDQD8WLcFSUDDbSUvqPp0XcX3fWw>
    <xmx:xvzGYBjdRT1sp1yP31qRhIMuRR_RFmFbBjjaQm6KDs0C4UK5Dd36zg>
    <xmx:xvzGYIpPaf5jo1tV5dIh9AhyND1eLOnTpOhF12u5lNGBpesfjM1lfQ>
    <xmx:x_zGYMpYenTwKY4FE9kfjnjuPm-mYnQjzAeX0IyQ999UAzRcHTWtiA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jun 2021 02:52:49 -0400 (EDT)
Message-ID: <4172edfc1e66a96efe687e94c18710682406f5d5.camel@themaw.net>
Subject: Re: [PATCH v6 5/7] kernfs: use i_lock to protect concurrent inode
 updates
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 14 Jun 2021 14:52:46 +0800
In-Reply-To: <43fe46a18bdc2e46f62a07f1e4a9b3d042ef3c01.camel@themaw.net>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
         <162322868275.361452.17585267026652222121.stgit@web.messagingengine.com>
         <YMQRzl4guvQQJwG0@zeniv-ca.linux.org.uk>
         <43fe46a18bdc2e46f62a07f1e4a9b3d042ef3c01.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-06-14 at 09:32 +0800, Ian Kent wrote:
> On Sat, 2021-06-12 at 01:45 +0000, Al Viro wrote:
> > On Wed, Jun 09, 2021 at 04:51:22PM +0800, Ian Kent wrote:
> > > The inode operations .permission() and .getattr() use the kernfs
> > > node
> > > write lock but all that's needed is to keep the rb tree stable
> > > while
> > > updating the inode attributes as well as protecting the update
> > > itself
> > > against concurrent changes.
> > 
> > Huh?  Where does it access the rbtree at all?  Confused...
> > 
> > > diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> > > index 3b01e9e61f14e..6728ecd81eb37 100644
> > > --- a/fs/kernfs/inode.c
> > > +++ b/fs/kernfs/inode.c
> > > @@ -172,6 +172,7 @@ static void kernfs_refresh_inode(struct
> > > kernfs_node *kn, struct inode *inode)
> > >  {
> > >         struct kernfs_iattrs *attrs = kn->iattr;
> > >  
> > > +       spin_lock(&inode->i_lock);
> > >         inode->i_mode = kn->mode;
> > >         if (attrs)
> > >                 /*
> > > @@ -182,6 +183,7 @@ static void kernfs_refresh_inode(struct
> > > kernfs_node *kn, struct inode *inode)
> > >  
> > >         if (kernfs_type(kn) == KERNFS_DIR)
> > >                 set_nlink(inode, kn->dir.subdirs + 2);
> > > +       spin_unlock(&inode->i_lock);
> > >  }
> > 
> > Even more so - just what are you serializing here?  That code
> > synchronizes inode
> > metadata with those in kernfs_node.  Suppose you've got two threads
> > doing
> > ->permission(); the first one gets through kernfs_refresh_inode()
> > and
> > goes into
> > generic_permission().  No locks are held, so kernfs_refresh_inode()
> > from another
> > thread can run in parallel with generic_permission().
> > 
> > If that's not a problem, why two kernfs_refresh_inode() done in
> > parallel would
> > be a problem?
> > 
> > Thread 1:
> >         permission
> >                 done refresh, all locks released now
> > Thread 2:
> >         change metadata in kernfs_node
> > Thread 2:
> >         permission
> >                 goes into refresh, copying metadata into inode
> > Thread 1:
> >                 generic_permission()
> > No locks in common between the last two operations, so
> > we generic_permission() might see partially updated metadata.
> > Either we don't give a fuck (in which case I don't understand
> > what purpose does that ->i_lock serve) *or* we need the exclusion
> > to cover a wider area.
> 
> This didn't occur to me, obviously.
> 
> It seems to me this can happen with the original code too although
> using a mutex might reduce the likelihood of it happening.
> 
> Still ->permission() is meant to be a read-only function so the VFS
> shouldn't need to care about it.
> 
> Do you have any suggestions on how to handle this.
> Perhaps the only way is to ensure the inode is updated only in
> functions that are expected to do this.

IIRC Greg and Tejun weren't averse to adding a field to the 
struct kernfs_iattrs, but there were concerns about increasing
memory usage.

Because of this I think the best way to handle this would be to
broaden the scope of the i_lock to cover the generic calls in
kernfs_iop_getattr() and kernfs_iop_permission(). The only other
call to kernfs_refresh_inode() is at inode initialization and
then only for I_NEW inodes so that should be ok. Also both
generic_permission() and generic_fillattr() are reading from the
inode so not likely to need to take the i_lock any time soon (is
this a reasonable assumption Al?).

Do you think this is a sensible way to go Al?

Ian

