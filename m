Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9853F1446C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 23:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgAUWBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 17:01:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgAUWBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dZeB8c6wopgB96kHzLsGfKTDmTGkWRYw4pK9aNqzzVs=; b=l/vGl+XIDfwJEgKyxps7e9pmb
        6oeWWS9WMuRsvDGmUjBAef8Kw4M0OODaaGL3qlCjf3vbqbMckx9P4LZOixuqTKC+kCkyAuBw+59q4
        U2HOR05RBU5fcBHWnu1qyYX6GBr2WYsRlZI3DGxo7bw+Ui5UuCV54n0DyRKmPOz/uIOo+ESfLLLuk
        m9RqEsVI+wUN4MjIaAAoTYaHvVWwwW9GDmPoVUYP4XN0lxwCQmwYecbx621sCli07zlu5adHOAnKC
        qd7uuP79fezL0uIOUTy/mRbNY53DmggYQ9XgjNUNMr9ZAB+XCNJD47LhbtokjxOo7H6Witb68uJO4
        Y26BBaMuw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iu1aD-0005hb-39; Tue, 21 Jan 2020 22:01:13 +0000
Date:   Tue, 21 Jan 2020 14:01:12 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Steve French <smfrench@gmail.com>,
        lsf-pc@lists.linux-foundation.org,
        xfs <xfs@e29208.dscx.akamaiedge.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Subject: Re: [Lsf-pc] [LFS/MM TOPIC] fs reflink issues, fs online
 scrub/check, etc
Message-ID: <20200121220112.GB14467@bombadil.infradead.org>
References: <20160210191715.GB6339@birch.djwong.org>
 <20160210191848.GC6346@birch.djwong.org>
 <CAH2r5mtM2nCicTKGFAjYtOG92TKKQdTbZxaD-_-RsWYL=Tn2Nw@mail.gmail.com>
 <0089aff3-c4d3-214e-30d7-012abf70623a@gmx.com>
 <CAOQ4uxjd-YWe5uHqfSW9iSdw-hQyFCwo84cK8ebJVJSY_vda3Q@mail.gmail.com>
 <20200121161840.GA8236@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121161840.GA8236@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 08:18:40AM -0800, Darrick J. Wong wrote:
> On Tue, Jan 21, 2020 at 09:35:22AM +0200, Amir Goldstein wrote:
> > On Tue, Jan 21, 2020 at 3:19 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > >
> > > Didn't see the original mail, so reply here.
> > 
> > Heh! Original email was from 2016, but most of Darrick's wish list is
> > still relevant in 2020 :)
> 
> Grumble grumble stable behavior of clonerange/deduperange ioctls across
> filesystems grumble grumble.
> 
> > I for one would be very interested in getting an update on the
> > progress of pagecache
> > page sharing if there is anyone working on it.
> 
> Me too.  I guess it's the 21st, I should really send in a proposal for
> *this year's* LSFMMBPFLOLBBQ.

I still have Strong Opinions on how pagecache page sharing should be done
... and half a dozen more important projects ahead of it in my queue.
So I have no update on this.
