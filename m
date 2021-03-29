Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D0834DC4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 01:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhC2XLT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 19:11:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55942 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhC2XKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:10:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 7822E1F454D3
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, ebiggers@google.com, drosen@google.com,
        ebiggers@kernel.org, yuchao0@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com
Subject: Re: [PATCH v5 4/4] fs: unicode: Add utf8 module and a unicode layer
Organization: Collabora
References: <20210329204240.359184-1-shreeya.patel@collabora.com>
        <20210329204240.359184-5-shreeya.patel@collabora.com>
        <87o8f1r71p.fsf@collabora.com>
        <bf430ae7-16a1-d4ca-3241-6f654524e7f9@collabora.com>
Date:   Mon, 29 Mar 2021 19:10:45 -0400
In-Reply-To: <bf430ae7-16a1-d4ca-3241-6f654524e7f9@collabora.com> (Shreeya
        Patel's message of "Tue, 30 Mar 2021 04:08:40 +0530")
Message-ID: <87a6qlr1xm.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shreeya Patel <shreeya.patel@collabora.com> writes:

> On 30/03/21 2:50 am, Gabriel Krisman Bertazi wrote:

>>> +DEFINE_STATIC_CALL(_unicode_strncmp, unicode_strncmp_default);
>>> +EXPORT_STATIC_CALL(_unicode_strncmp);
>>>   -int unicode_strncmp(const struct unicode_map *um,
>>> -		    const struct qstr *s1, const struct qstr *s2)
>>> -{
>>> -	const struct utf8data *data = utf8nfdi(um->version);
>>> -	struct utf8cursor cur1, cur2;
>>> -	int c1, c2;
>>> +DEFINE_STATIC_CALL(_unicode_strncasecmp, unicode_strncasecmp_default);
>>> +EXPORT_STATIC_CALL(_unicode_strncasecmp);
>> Why are these here if the _default functions are defined in the header
>> file?  I think the definitions could be in this file. No?
>
>
> Inline functions defined in header file are using these functions so
> cannot define them here in .c file.

That is not a problem.  It is regular C code, you can just move the
definition to the C code and add the declaration to the header file, and
it will work fine.

-- 
Gabriel Krisman Bertazi
