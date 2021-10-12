Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E667942A77A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 16:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbhJLOnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 10:43:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54100 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbhJLOnL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:43:11 -0400
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C039F1F43333;
        Tue, 12 Oct 2021 15:41:08 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 10/11] unicode: Add utf8-data module
Organization: Collabora
References: <20210915070006.954653-1-hch@lst.de>
        <20210915070006.954653-11-hch@lst.de> <87wnmipjrw.fsf@collabora.com>
        <20211012124904.GB9518@lst.de>
Date:   Tue, 12 Oct 2021 11:40:56 -0300
In-Reply-To: <20211012124904.GB9518@lst.de> (Christoph Hellwig's message of
        "Tue, 12 Oct 2021 14:49:04 +0200")
Message-ID: <87sfx6papz.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> [fullquote deleted]
>
> On Tue, Oct 12, 2021 at 08:25:23AM -0300, Gabriel Krisman Bertazi wrote:
>> > @@ -187,6 +207,7 @@ EXPORT_SYMBOL(utf8_load);
>> >  
>> >  void utf8_unload(struct unicode_map *um)
>> >  {
>> > +	symbol_put(utf8_data_table);
>> 
>> This triggers a BUG_ON if the symbol isn't loaded/loadable,
>> i.e. ext4_fill_super fails early.  I'm not sure how to fix it, though.
>
> Does this fix it?

Yes, it does.

I  will fold this into the original patch and queue this series for 5.16.

Thank you,

-- 
Gabriel Krisman Bertazi
