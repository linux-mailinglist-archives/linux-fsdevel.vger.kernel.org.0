Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE62548838
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 18:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355183AbiFMO5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 10:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241654AbiFMO5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 10:57:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0880D80A8
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jun 2022 04:59:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 68A171F38A;
        Mon, 13 Jun 2022 11:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655121550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MtaDkSTsqZB2N4cu2+iMP7NifscKGHK83cRkNJtJRmY=;
        b=kYry5WLZPt8QgK932vtihfgnf4/R9WMbmuPoPA8dx8WfIS5j82sxqXq5HoDR/smbLIq3PH
        h+UU2qrnXuBW+AMHLCs9K/6AOiVNMG9FhP0QuhvBjPXJDD77J8bixEIlx+KMzhGZQVEaW3
        0xcZaFYpx6CnnDceB/BfcUeZp+IRhag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655121550;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MtaDkSTsqZB2N4cu2+iMP7NifscKGHK83cRkNJtJRmY=;
        b=AtFdndIAxHsV1Rzph+EqibF0s4UZe8Qb17ys8eNr9FqRU1lDXJpTbhSaa2f6qsjg/PLmNl
        a/SXlDSs0e6MIGCg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4294E2C141;
        Mon, 13 Jun 2022 11:59:10 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D235FA0634; Mon, 13 Jun 2022 13:59:09 +0200 (CEST)
Date:   Mon, 13 Jun 2022 13:59:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: LTP test for fanotify evictable marks
Message-ID: <20220613115909.fkprdllsxawc3trg@quack3.lan>
References: <20220307155741.1352405-1-amir73il@gmail.com>
 <20220317141204.hbpflysc7p5e5vdo@quack3.lan>
 <CAOQ4uxh2KuLk21530upP0VYWDrks1m++0jfk6RGqGVayNnEHcg@mail.gmail.com>
 <CAOQ4uxhx=-RT_J-hiogPE9=LTyYVD2Q7FnZH03Hgba4Y3eh-QA@mail.gmail.com>
 <CAOQ4uxjuM4p7S6sg6R5=7skcKcC7GFcsrZ7ZftdadkLP4-Fk=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjuM4p7S6sg6R5=7skcKcC7GFcsrZ7ZftdadkLP4-Fk=g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 13-06-22 08:40:37, Amir Goldstein wrote:
> On Sun, Mar 20, 2022 at 2:54 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Mar 17, 2022 at 5:14 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Thu, Mar 17, 2022 at 4:12 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Mon 07-03-22 17:57:36, Amir Goldstein wrote:
> > > > > Jan,
> > > > >
> > > > > Following RFC discussion [1], following are the volatile mark patches.
> > > > >
> > > > > Tested both manually and with this LTP test [2].
> > > > > I was struggling with this test for a while because drop caches
> > > > > did not get rid of the un-pinned inode when test was run with
> > > > > ext2 or ext4 on my test VM. With xfs, the test works fine for me,
> > > > > but it may not work for everyone.
> > > > >
> > > > > Perhaps you have a suggestion for a better way to test inode eviction.
> > > >
> > > > Drop caches does not evict dirty inodes. The inode is likely dirty because
> > > > you have chmodded it just before drop caches. So I think calling sync or
> > > > syncfs before dropping caches should fix your problems with ext2 / ext4.  I
> > > > suspect this has worked for XFS only because it does its private inode
> > > > dirtiness tracking and keeps the inode behind VFS's back.
> > >
> > > I did think of that and tried to fsync which did not help, but maybe
> > > I messed it up somehow.
> > >
> >
> > You were right. fsync did fix the test.
> 
> Hi Jan,
> 
> I was preparing to post the LTP test for FAN_MARK_EVICTABLE [1]
> and I realized the issue we discussed above was not really resolved.
> fsync() + drop_caches is not enough to guarantee reliable inode eviction.
> 
> It "kind of" works for ext2 and xfs, but not for ext4, ext3, btrfs.
> "kind of" because even for ext2 and xfs, dropping only inode cache (2)
> doesn't evict the inode/mark and dropping inode+page cache (3) does work
> most of the time, although I did occasionally see failures.
> I suspect those failures were related to running the test on a system
> with very low page cache usage.
> The fact that I had to tweak vfs_cache_pressure to increase test reliability
> also suggests that there are heuristics at play.

Well, yes, there's no guaranteed way to force inode out of cache. It is all
best-effort stuff. When we needed to make sure inode goes out of cache on
nearest occasion, we have introduced d_mark_dontcache() but there's no
fs common way to set this flag on dentry and I don't think we want to
expose one.

I was thinking whether we have some more reliable way to test this
functionality and I didn't find one. One other obvious approach to the test
is to create memcgroup with low memory limit, tag large tree with evictable
mark, and see whether the memory gets exhausted. This is kind of where this
functionality is aimed. But there are also variables in this testing scheme
that may be difficult to tame and the test will likely take rather long
time to perform.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
