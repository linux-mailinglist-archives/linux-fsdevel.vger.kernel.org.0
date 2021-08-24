Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8E43F581C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 08:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhHXGVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 02:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232320AbhHXGVs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 02:21:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCE6861027;
        Tue, 24 Aug 2021 06:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629786063;
        bh=bL+8jiRZvadmenfA31Udhy/TMRIUStlfq31nSmr/TQE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qL0cPbHZeqU1SyWmVUnYHj/kL8KHMQlf8rafFgih3hQg5bl9vuWMHnAfyD/JK7Bmp
         xfzQDveTkstSjfNBzKAkMicLI7X6IrP3qHyltCzkKh51w+pOUoP7CwObhP28ZOmE39
         /KH2kAKU/MecL2dEejhjKhD60v/nA8CXyBhNQob/iWqf2l9XoeIjICCts1O76Z1awH
         H+FOQV8+8BCDvsnkkW3tK6c5lxOxqNJp+vBdAGbT0RhGabJGdSD2OyBJQJuInuqNW7
         mMXp7yofmJ/JC9Wx/kMoNPWP1q7gIFrYJpJbPEzjeopN2VAhV7CoT1ErNgGoCsWxh2
         I5+6CyIErkX9Q==
Subject: Re: [f2fs-dev] [PATCH 02/11] f2fs: simplify f2fs_sb_read_encoding
To:     Christoph Hellwig <hch@lst.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Shreeya Patel <shreeya.patel@collabora.com>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210818140651.17181-1-hch@lst.de>
 <20210818140651.17181-3-hch@lst.de>
From:   Chao Yu <chao@kernel.org>
Message-ID: <1fb2db25-289b-36d5-a72e-091d7282726c@kernel.org>
Date:   Tue, 24 Aug 2021 14:21:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818140651.17181-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/8/18 22:06, Christoph Hellwig wrote:
> Return the encoding table as the return value instead of as an argument,
> and don't bother with the encoding flags as the caller can handle that
> trivially.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
