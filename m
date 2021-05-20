Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBAB38B83E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 22:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbhETUVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 16:21:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50624 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbhETUVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 16:21:24 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 8941C1F43E17
Subject: Re: [PATCH v8 4/4] fs: unicode: Add utf8 module and a unicode layer
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, chao@kernel.org, ebiggers@google.com,
        drosen@google.com, ebiggers@kernel.org, yuchao0@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
References: <20210423205136.1015456-1-shreeya.patel@collabora.com>
 <20210423205136.1015456-5-shreeya.patel@collabora.com>
 <20210427062907.GA1564326@infradead.org>
 <61d85255-d23e-7016-7fb5-7ab0a6b4b39f@collabora.com>
 <YIgkvjdrJPjeoJH7@mit.edu> <87bl9z937q.fsf@collabora.com>
 <YIlta1Saw7dEBpfs@mit.edu> <87mtti6xtf.fsf@collabora.com>
 <7caab939-2800-0cc2-7b65-345af3fce73d@collabora.com>
 <YJoJp1FnHxyQc9/2@infradead.org>
From:   Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <687283ac-77b9-9e9e-dac2-faaf928eb383@collabora.com>
Date:   Fri, 21 May 2021 01:49:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJoJp1FnHxyQc9/2@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/05/21 10:05 am, Christoph Hellwig wrote:
> On Tue, May 11, 2021 at 02:17:00AM +0530, Shreeya Patel wrote:
>> Theodore / Christoph, since we haven't come up with any final decision with
>> this discussion, how do you think we should proceed on this?
> I think loading it as a firmware-like table is much preferable to
> a module with all the static call magic papering over that it really is
> just one specific table.


Christoph, I get you point here but request_firmware API requires a 
device pointer and I don't
see anywhere it being NULL so I am not sure if we are going in the right 
way by loading the data as firmware like table.




