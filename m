Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7FBAA42DC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 08:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfHaGq2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 02:46:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfHaGq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 02:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KWT3ZplPKtK7Y/T0S67CqNjF7OkqyyNMh/wHljSWwiU=; b=jVUY9VrAda1+qJvsHySytQ2LdR
        CxOnHDwJwePxIIeIiSRRi1BNQy/GFz/+L8HW8VrxUTdbiaeTu4HPJ01dlvWC1sytox74MsgkIMu4U
        rO5vGPpPwJhe/HOB4fYKeU6k4WT4tC3qAXrwUNPZPBMfHbPwFw1u04hfBtBtjU0sF8xnD4fBIgZ6x
        1AKcXWOSXiKAZJ7yLrWKlpwOOSEIK9OWG87iE4egH5TfrILcYnDPUccsl+ITYax6zE8mNohSFVUvs
        fkfAyItPBOp60wDDZzJMNKNmkaRHCXqVtQ9oyEVd6dTq43Qh8F4QlIWRY77TJcIu7X8JfUduCnV4B
        rOVylb0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3x9M-0004oM-Sa; Sat, 31 Aug 2019 06:46:16 +0000
Date:   Fri, 30 Aug 2019 23:46:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of
 fat/vfat
Message-ID: <20190831064616.GA13286@infradead.org>
References: <245727.1567183359@turing-police>
 <20190830164503.GA12978@infradead.org>
 <267691.1567212516@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <267691.1567212516@turing-police>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 30, 2019 at 08:48:36PM -0400, Valdis Klētnieks wrote:
> Explain how it's half-a**ed.  You worry about accidental mounting, meanwhile
> down in the embedded space there are memory-constrained machines that
> don't want separate vfat and exfat drivers sitting around in memory. If you
> have a better patch that addresses both concerns, feel free to submit it.

Since when did Linux kernel submissions become "show me a better patch"
to reject something obviously bad?

As I said the right approach is to probably (pending comments from the
actual fat maintainer) to merge exfat support into the existing fs/fat/
codebase.  You obviously seem to disagree (and at the same time not).

But using this as a pre-text of adding a non-disabled second fat16/32
implementation and actually allowing that to build with no reason is
just not how it works.

> > done.  Given that you signed up as the maintainer for this what is your
> > plan forward on it?  What development did you on the code and what are
> > your next steps?
> 
> Well, the *original* plan was to get it into the tree someplace so it can get
> review and updates from others.

In other words you have no actual plan and no idea what to do and want to
rely on "others" to do anything, but at the same time reject the
comments from others how to do things right?

> Given the amount of press the Microsoft
> announcement had, we were *hoping* there would be some momentum and
> people actually looking at the code and feeding me patches. I've gotten a
> half dozen already today....

And all of that you can easily do by just sending out a patch series.
And maybe actually listening to comments.

> Although if you prefer, it can just sit out-of-tree until I've got a perfect driver
> without input or review from anybody.  But I can't think of *any* instance where
> that model has actually worked.

You generally get a lot of review and comments by posting to the mailing
list.  But what really helps is to just do the very basic homework
beforehand.  And it also really helps to have a plan what you want to
do with a codebase you just copy and pasted from somewhere.
