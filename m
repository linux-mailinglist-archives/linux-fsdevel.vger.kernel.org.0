Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E08B4AA37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 20:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfFRSsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jun 2019 14:48:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50684 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbfFRSsX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:48:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hdJ9Z-00015d-D9; Tue, 18 Jun 2019 18:48:21 +0000
Date:   Tue, 18 Jun 2019 19:48:21 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Vicente Bergas <vicencb@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: d_lookup: Unable to handle kernel paging request
Message-ID: <20190618184821.GC17978@ZenIV.linux.org.uk>
References: <23950bcb-81b0-4e07-8dc8-8740eb53d7fd@gmail.com>
 <20190522135331.GM17978@ZenIV.linux.org.uk>
 <bdc8b245-afca-4662-99e2-a082f25fc927@gmail.com>
 <20190522162945.GN17978@ZenIV.linux.org.uk>
 <10192e43-c21d-44e4-915d-bf77a50c22c4@gmail.com>
 <20190618183548.GB17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618183548.GB17978@ZenIV.linux.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 18, 2019 at 07:35:48PM +0100, Al Viro wrote:

> So far it looks like something is buggering a forward reference
> in hash chain in a fairly specific way - the values seen had been
> 00000000010000000 and
> 00008800010000000.  Does that smell like anything from arm64-specific
> data structures (PTE, etc.)?

make that 0000000001000000 and 0000880001000000 resp.  Tests in the
patch are correct, just mistyped it here...

> Alternatively, we might've gone off rails a step (or more) before,
> with the previous iteration going through bogus, but at least mapped
> address - the one that has never been a dentry in the first place.
