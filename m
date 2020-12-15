Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832702DB251
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Dec 2020 18:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgLORN5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 12:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbgLORNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 12:13:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32948C06179C;
        Tue, 15 Dec 2020 09:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bamt1vhWflLJrYhbxJ6k9pb1zAhvy1g84sptwRL1GYk=; b=PUZKg54KJus743ak0xZTUApmPd
        6WH6ZnYi3YOjC1nUpiEPrO148SqGOj0g1s0HHuge//upi8cwb1DS1T6zQfWn8OL/OzRH+sj4CJcoG
        bG8D6+CEERiZZpttZfb9soa6jxkrwD+zqmLFCb8Vvyui2IjGHOP7H8mja7qO9caQidHTmGQwbc5b+
        hpoAbKY9ydjAJSE14HbXJiIcVb5ptFvkrBAdhzJRBP3neGCnJ6EL6TpQKYqImR/jnQ/gO+mDIiGoz
        76xG9Lohd9b5asuF0Us64GfvXIvCmb4WVjxm+SqBtIQQsX0Gj7cvWzPDuBUTxd8J/L6syyoS/i5SR
        hH/EpRTw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpDst-0005M1-7w; Tue, 15 Dec 2020 17:13:11 +0000
Date:   Tue, 15 Dec 2020 17:13:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sergey Temerkhanov <s.temerkhanov@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fget: Do not loop with rcu lock held
Message-ID: <20201215171311.GV2443@casper.infradead.org>
References: <20201215164123.609980-1-s.temerkhanov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215164123.609980-1-s.temerkhanov@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 15, 2020 at 07:41:23PM +0300, Sergey Temerkhanov wrote:
> Unlock RCU before running another loop iteration

Why?
