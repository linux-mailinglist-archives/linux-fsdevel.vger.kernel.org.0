Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AEF3A5D8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 09:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhFNHTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 03:19:05 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:41851 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232498AbhFNHTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 03:19:03 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4802E580C24;
        Mon, 14 Jun 2021 03:17:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 14 Jun 2021 03:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        4fr5SDHy37EcRezWa7kOUkmOhocGu42HH+g7wJIzW7s=; b=uuiugjIQd2Bp5F5j
        BbUbhj2GCMiagWlQsQJCJ3E/dpPrZA7dpgCKFZmLBrhWeN9wTL2MkLn6ZPWfA/6e
        55It0KVGjfeiv75nyNNaWMdO0XtV1Knk9wX/td1ZNX8TPZgnvUeXlucTD71qFd23
        2ABtLnMeqACJXXWFi9EC6rBPeNZdtBazmV9OjzmfAbhwJvJGLJKEYuYeheVryeI3
        Vc1UpI/zrEjGTkSyWZGDyWJQr9ao94Om11KMEIjongp5/l2wmUnXTkIYYS92FLmQ
        lumz9A4tMJYeynSXCBzCjAbsMjTjsd2f96GT1Kip2eYVpoYznFac/aBRmk/km/ru
        npl/9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=4fr5SDHy37EcRezWa7kOUkmOhocGu42HH+g7wJIzW
        7s=; b=QCWThDqlgfklmmLHwVZq1lMX2RWQ27cl1yuE9aT4bRXBPmDG2mtSVined
        gdRZz7mRNKZ+bSxoxwJXudh/ZCmVD6JEFG+ngGF7iVkF6p/qZrqRwaMu/xT7pbzA
        1JDvlKPyZD5LzasALha25qxpBUXT1+s35b0cPRSWKCp5nB68vV+wyQfiGvs/zDOM
        jzIgsXwJQdUPtrlfj3ll26HK2eZBy8l3MeyAYfZM/RsBRnGKvQpMPrfk3vqXE6YL
        bM1vweJ7ZZy3QGw9JUBVUiLzh68i3OJi4T2E1zAQnaOxb8z6tx1921E92JxnJgs6
        Zjj1jVyEvuojrI60YDd0sUTeRJHMg==
X-ME-Sender: <xms:bALHYEdvBLmLOUKPtYKG_HAlnPoRdvLvGqmDz2CwB6b1Z05tKXNRmg>
    <xme:bALHYGNHRzKqoI6g2T1gSCBN3hWInHu5SgpojTb_4kj-Tyj-UsVByRFmfi58AdC2g
    Bworf3bwDK0>
X-ME-Received: <xmr:bALHYFivIBPL3fkBkRcAn4kQ0PXOjuf4RdNE1-IEka3jH9VUkF6dQRdD7No3bgHUmWsORawxEpeTHwCRyJxfNOf4CN9zmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvgedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epgfelleekteehleegheeujeeuudfhueffgfelhefgvedthefhhffhhfdtudfgfeehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:bALHYJ8kd7xPhKeDj5WNzhkuEKFB_JegPyNFTx3ZZ6zUGKGvbuxlJg>
    <xmx:bALHYAs2eSrJ0HGfXBThkiBHebzNMbE7Z-uv0Fih5iY2HDT5tPWAJg>
    <xmx:bALHYAGBNNmTFtp37VjoGywnFREJZdcEhT_LTBsyJCJR2SmcmlldjA>
    <xmx:bQLHYAHWYKLutpqk1dbfUmB8xjYy-ageANkXDXLlMh1kJifl4kVkug>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jun 2021 03:16:55 -0400 (EDT)
Message-ID: <83baef7ddeaf9d60885933683eeaff8511eff10e.camel@themaw.net>
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
Date:   Mon, 14 Jun 2021 15:16:51 +0800
In-Reply-To: <4172edfc1e66a96efe687e94c18710682406f5d5.camel@themaw.net>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
         <162322868275.361452.17585267026652222121.stgit@web.messagingengine.com>
         <YMQRzl4guvQQJwG0@zeniv-ca.linux.org.uk>
         <43fe46a18bdc2e46f62a07f1e4a9b3d042ef3c01.camel@themaw.net>
         <4172edfc1e66a96efe687e94c18710682406f5d5.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-06-14 at 14:52 +0800, Ian Kent wrote:
> On Mon, 2021-06-14 at 09:32 +0800, Ian Kent wrote:
> > On Sat, 2021-06-12 at 01:45 +0000, Al Viro wrote:
> > > On Wed, Jun 09, 2021 at 04:51:22PM +0800, Ian Kent wrote:
> > > > The inode operations .permission() and .getattr() use the
> > > > kernfs
> > > > node
> > > > write lock but all that's needed is to keep the rb tree stable
> > > > while
> > > > updating the inode attributes as well as protecting the update
> > > > itself
> > > > against concurrent changes.
> > > 
> > > Huh?  Where does it access the rbtree at all?  Confused...
> > > 
> > > > diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
> > > > index 3b01e9e61f14e..6728ecd81eb37 100644
> > > > --- a/fs/kernfs/inode.c
> > > > +++ b/fs/kernfs/inode.c
> > > > @@ -172,6 +172,7 @@ static void kernfs_refresh_inode(struct
> > > > kernfs_node *kn, struct inode *inode)
> > > >  {
> > > >         struct kernfs_iattrs *attrs = kn->iattr;
> > > >  
> > > > +       spin_lock(&inode->i_lock);
> > > >         inode->i_mode = kn->mode;
> > > >         if (attrs)
> > > >                 /*
> > > > @@ -182,6 +183,7 @@ static void kernfs_refresh_inode(struct
> > > > kernfs_node *kn, struct inode *inode)
> > > >  
> > > >         if (kernfs_type(kn) == KERNFS_DIR)
> > > >                 set_nlink(inode, kn->dir.subdirs + 2);
> > > > +       spin_unlock(&inode->i_lock);
> > > >  }
> > > 
> > > Even more so - just what are you serializing here?  That code
> > > synchronizes inode
> > > metadata with those in kernfs_node.  Suppose you've got two
> > > threads
> > > doing
> > > ->permission(); the first one gets through kernfs_refresh_inode()
> > > and
> > > goes into
> > > generic_permission().  No locks are held, so
> > > kernfs_refresh_inode()
> > > from another
> > > thread can run in parallel with generic_permission().
> > > 
> > > If that's not a problem, why two kernfs_refresh_inode() done in
> > > parallel would
> > > be a problem?
> > > 
> > > Thread 1:
> > >         permission
> > >                 done refresh, all locks released now
> > > Thread 2:
> > >         change metadata in kernfs_node
> > > Thread 2:
> > >         permission
> > >                 goes into refresh, copying metadata into inode
> > > Thread 1:
> > >                 generic_permission()
> > > No locks in common between the last two operations, so
> > > we generic_permission() might see partially updated metadata.
> > > Either we don't give a fuck (in which case I don't understand
> > > what purpose does that ->i_lock serve) *or* we need the exclusion
> > > to cover a wider area.
> > 
> > This didn't occur to me, obviously.
> > 
> > It seems to me this can happen with the original code too although
> > using a mutex might reduce the likelihood of it happening.
> > 
> > Still ->permission() is meant to be a read-only function so the VFS
> > shouldn't need to care about it.
> > 
> > Do you have any suggestions on how to handle this.
> > Perhaps the only way is to ensure the inode is updated only in
> > functions that are expected to do this.
> 
> IIRC Greg and Tejun weren't averse to adding a field to the 
> struct kernfs_iattrs, but there were concerns about increasing
> memory usage.
> 
> Because of this I think the best way to handle this would be to
> broaden the scope of the i_lock to cover the generic calls in
> kernfs_iop_getattr() and kernfs_iop_permission(). The only other
> call to kernfs_refresh_inode() is at inode initialization and
> then only for I_NEW inodes so that should be ok. Also both
> generic_permission() and generic_fillattr() are reading from the
> inode so not likely to need to take the i_lock any time soon (is
> this a reasonable assumption Al?).
> 
> Do you think this is a sensible way to go Al?

Unless of course we don't care about taking a lock here at all,
Greg, Tejun?


Ian

