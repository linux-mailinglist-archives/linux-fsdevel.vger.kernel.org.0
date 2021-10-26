Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2920143B368
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 15:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbhJZN6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 09:58:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40258 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbhJZN6v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 09:58:51 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 14CAA1F43A4A;
        Tue, 26 Oct 2021 14:56:25 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 10/11] unicode: Add utf8-data module
Organization: Collabora
References: <20210915070006.954653-1-hch@lst.de>
        <20210915070006.954653-11-hch@lst.de> <87wnmipjrw.fsf@collabora.com>
        <20211012124904.GB9518@lst.de> <87sfx6papz.fsf@collabora.com>
        <20211026074509.GA594@lst.de>
Date:   Tue, 26 Oct 2021 10:56:20 -0300
In-Reply-To: <20211026074509.GA594@lst.de> (Christoph Hellwig's message of
        "Tue, 26 Oct 2021 09:45:09 +0200")
Message-ID: <87mtmvevp7.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Tue, Oct 12, 2021 at 11:40:56AM -0300, Gabriel Krisman Bertazi wrote:
>> > Does this fix it?
>> 
>> Yes, it does.
>> 
>> I  will fold this into the original patch and queue this series for 5.16.
>
> This series still doesn't seem to be queued up.

Hm, I'm keeping it here:

https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git/log/?h=for-next_5.16

Sorry, but I'm not sure what is the process to get tracked by
linux-next.  I'm Cc'ing Stephen to hopefully help me figure it out.

Thanks,

-- 
Gabriel Krisman Bertazi
