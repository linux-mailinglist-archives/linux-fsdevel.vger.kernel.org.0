Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC916FF9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 14:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgBZNFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 08:05:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgBZNFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YWIvxqR0O64iCW+32RSdIg/0pnbQba367tq67f6Dqzw=; b=Mpa4FPkNfAILKJDnTcy/rhSkdm
        cFSHlvDUtzPkU0Rlb+MOZNtS1ck1IKFYswb00odKVY/8FGc+d4/1zmp20ideLYyEoGEm+f/R1yoTK
        IxSYDKG+Ti+QUv7+8BzoB1nsOcrkOG1TtO4yfOxqBYwohCirhUQP8QFpOfJxJw5wfX84tacjfak1+
        kU7YMXMQQUMGeYV7N6JFbkTpitay+gzPXVUvZwHwytX4uMTk0HzAPHeSbyI5wM3sxn09pMzLfaDfH
        zKxBXghYvS2pPJJXGKeJp0+VQaIBCMIWRzl1PNxMMdr0t02ctFarpk1yfuqMkf/vOzt400DqE70bw
        ir+zQPRw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6wN5-0002AC-8T; Wed, 26 Feb 2020 13:05:03 +0000
Date:   Wed, 26 Feb 2020 05:05:03 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com
Subject: Re: [PATCHv3 6/6] Documentation: Correct the description of
 FIEMAP_EXTENT_LAST
Message-ID: <20200226130503.GY24185@bombadil.infradead.org>
References: <cover.1582702693.git.riteshh@linux.ibm.com>
 <279638c6939b1f6ef3ab32912cb51da1a967cf8e.1582702694.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <279638c6939b1f6ef3ab32912cb51da1a967cf8e.1582702694.git.riteshh@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 03:27:08PM +0530, Ritesh Harjani wrote:
> Currently FIEMAP_EXTENT_LAST is not working consistently across
> different filesystem's fiemap implementations and thus this feature
> may be broken. So fix the documentation about this flag to meet the
> right expectations.

Are you saying filesystems have both false positives and false negatives?
I can understand how a filesystem might fail to set FIEMAP_EXTENT_LAST,
but not how a filesystem might set it when there's actually another
extent beyond this one.

>  * FIEMAP_EXTENT_LAST
> -This is the last extent in the file. A mapping attempt past this
> -extent will return nothing.
> +This is generally the last extent in the file. A mapping attempt past this
> +extent may return nothing. But the user must still confirm by trying to map
> +past this extent, since different filesystems implement this differently.
