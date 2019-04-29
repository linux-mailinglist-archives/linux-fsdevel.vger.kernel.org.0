Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67580ED6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 01:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbfD2Xyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 19:54:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfD2Xyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 19:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=I94i2XopXQ46FN2+ICJ8tUvwfkgSChVjAq2FWTJ7nOE=; b=XVAnUdT6fvHvWcWmZqhFeJISJ
        MXT4h3EJtPImMuTLE+kaEEPyTB/Hi3wGtAUsFL7uO3ixt1bUt6dZ9FV9OCVXkxA/FxcoN926tiz5p
        fhKiGBkojfqxYwvMQ+oYiTZtqEBtfO3QdZ41dqYfI2Ys9mt/FjQ+MtHD8yctwnEb5ex2wuzBOfrhx
        RaDXgl1DKXZw+i1wTb/puevOm3kKihxGgoW7HRt8oTPpV7H4y8+a9I4FQdD8eLb7BhH+e1p9zazs2
        DrSi5VNb+7bCqMzjG2VuPcLBF9D/iggrvSpLrwpY1CgzKDfLstdbGmPxUxJtvDNx3zqoD6Rb5lB2g
        hNf150imw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLG6b-0004Wt-6L; Mon, 29 Apr 2019 23:54:41 +0000
Date:   Mon, 29 Apr 2019 16:54:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Scheduling conflicts
Message-ID: <20190429235440.GA13796@bombadil.infradead.org>
References: <20190425200012.GA6391@redhat.com>
 <83fda245-849a-70cc-dde0-5c451938ee97@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83fda245-849a-70cc-dde0-5c451938ee97@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 25, 2019 at 02:03:34PM -0600, Jens Axboe wrote:
> On 4/25/19 2:00 PM, Jerome Glisse wrote:
> > Did i miss preliminary agenda somewhere ? In previous year i think
> > there use to be one by now :)
> 
> You should have received an email from LF this morning with a subject
> of:
> 
> LSFMM 2019: 8 Things to Know Before You Arrive!
> 
> which also includes a link to the schedule. Here it is:
> 
> https://docs.google.com/spreadsheets/d/1Z1pDL-XeUT1ZwMWrBL8T8q3vtSqZpLPgF3Bzu_jejfk

The schedule continues to evolve ... I would very much like to have
Christoph Hellwig in the room for the Eliminating Tail Pages discussion,
but he's now scheduled to speak in a session at the same time (16:00
Tuesday).  I assume there'll be time for agenda-bashing at 9am tomorrow?
