Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D14B11A0EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 02:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfLKB6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 20:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfLKB6e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:58:34 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCF6B205ED;
        Wed, 11 Dec 2019 01:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576029514;
        bh=Cl621FHhPK2h2B+bxkrI0DSZWi6mXa++22Ve9vlh+p4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bL6riMTuah6/luBGs/RHWU7mviWpfnMG1EYT24qFmW2QlqnIWX5R6pf1urcJjcPAJ
         FxgzOmqKIfbDyj8F6qhq3lUZUbVT8GWhrUhNNQwf0grxFC9hyvojD1CVdBzEtC1SeG
         kLrJkeemHVvUVUO5bSFMXjqhNMxoBL/yxnV1LR40=
Date:   Tue, 10 Dec 2019 17:58:33 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     <broonie@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-next@vger.kernel.org>, <mhocko@suse.cz>,
        <mm-commits@vger.kernel.org>, <sfr@canb.auug.org.au>,
        jinyuqi <jinyuqi@huawei.com>
Subject: Re: mmotm 2019-12-06-19-46 uploaded
Message-Id: <20191210175833.6fc3360899bec1f99321528a@linux-foundation.org>
In-Reply-To: <f4596325-a5cd-935e-38a3-61ca36aae9ae@hisilicon.com>
References: <20191207034723.OPvz2A9wZ%akpm@linux-foundation.org>
        <c0691301-fa72-b9fe-5cb8-815275f84555@hisilicon.com>
        <20191210173507.5f4b46bde9586456c2132560@linux-foundation.org>
        <f4596325-a5cd-935e-38a3-61ca36aae9ae@hisilicon.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 11 Dec 2019 09:42:09 +0800 Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:

> Hi Andrew,
> 
> On 2019/12/11 9:35, Andrew Morton wrote:
> > On Mon, 9 Dec 2019 14:31:55 +0800 Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
> > 
> >> Hi Andrew,
> >>
> >> About this patch,
> >> https://lore.kernel.org/lkml/1573091048-10595-1-git-send-email-zhangshaokun@hisilicon.com/
> >>
> >> It is not in linux-next or your trees now, has it been dropped?
> > 
> > Yes, I dropped it with a "to be updated" note.  Michal is asking for
> > significant changelog updates (at least).
> 
> Ok, Shall I rebase on 5.5-rc1 and send patch v4?

Yes please.  Please ensure that all review comments have been
addressed, either with code changes or with changelog additions.

