Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5BA210187
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 03:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgGABd5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 21:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgGABd4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:33:56 -0400
Received: from X1 (071-093-078-081.res.spectrum.com [71.93.78.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79DB2074D;
        Wed,  1 Jul 2020 01:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593567236;
        bh=f1yB5Zra8JE7ZxnZ7PpU1nJ8yXL5iYPCKmc0wIacENI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tygY2kWV4JVtZg0Dh2rn7ZKNDFI5JVQoLDJUSlF2nkMO9YWjPFeiXf/CvJGCjKg8A
         PHTRS6pQ0OIMgj3oRBG614IePcy+t9edRW6tcaCj12Dk0svHahtq1GCl/lB9SS8B/b
         bjWFmRkczS/XJe2yNQTH39U7+ev2bzY0whZmQO2I=
Date:   Tue, 30 Jun 2020 18:33:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/7] mm: Replace hpage_nr_pages with thp_nr_pages
Message-Id: <20200630183354.45a8574844ae7e2cf2c9429c@linux-foundation.org>
In-Reply-To: <20200629183228.GH25523@casper.infradead.org>
References: <20200629151959.15779-1-willy@infradead.org>
        <20200629151959.15779-6-willy@infradead.org>
        <8bf5ae79-eace-5345-1a77-69d9e2e083b3@oracle.com>
        <20200629181440.GG25523@casper.infradead.org>
        <20200629183228.GH25523@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 29 Jun 2020 19:32:28 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> So I think you found the only bug of this type, although I'm a little
> unsure about the rmap_walk_file().

So...  I'll assume that this part of this patch ("mm: Replace
hpage_nr_pages with thp_nr_pages") is to be dropped.

