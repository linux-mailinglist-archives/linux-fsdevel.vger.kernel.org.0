Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8EAA11A08F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 02:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLKBfN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 20:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfLKBfI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:35:08 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 893CC206EC;
        Wed, 11 Dec 2019 01:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576028107;
        bh=c9m9fown74Zh8IIFCHcE5o2mKOa4ALygmoYsqibpZwk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R7hTCIb9LYwpUcXG44PFXDu+rF4suDUOZKbHWvoL7hLLRxAEjLpWCQ89pl9HmxTcQ
         WvHhxdTdSjluLvbeRKD4ihTnNKoO0LnuvFHanplpkTMBhLn5UB9iIT02VQ0CMLsxAx
         m7u1uzUiT5NEoiNI4Xq1FTk3WSdbbps6KQBGiNIk=
Date:   Tue, 10 Dec 2019 17:35:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     <broonie@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-next@vger.kernel.org>, <mhocko@suse.cz>,
        <mm-commits@vger.kernel.org>, <sfr@canb.auug.org.au>,
        jinyuqi <jinyuqi@huawei.com>
Subject: Re: mmotm 2019-12-06-19-46 uploaded
Message-Id: <20191210173507.5f4b46bde9586456c2132560@linux-foundation.org>
In-Reply-To: <c0691301-fa72-b9fe-5cb8-815275f84555@hisilicon.com>
References: <20191207034723.OPvz2A9wZ%akpm@linux-foundation.org>
        <c0691301-fa72-b9fe-5cb8-815275f84555@hisilicon.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 9 Dec 2019 14:31:55 +0800 Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:

> Hi Andrew,
> 
> About this patch,
> https://lore.kernel.org/lkml/1573091048-10595-1-git-send-email-zhangshaokun@hisilicon.com/
> 
> It is not in linux-next or your trees now, has it been dropped?

Yes, I dropped it with a "to be updated" note.  Michal is asking for
significant changelog updates (at least).

