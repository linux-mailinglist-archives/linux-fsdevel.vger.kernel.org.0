Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB08432C569
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353456AbhCDAUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:36 -0500
Received: from p3plsmtpa11-09.prod.phx3.secureserver.net ([68.178.252.110]:52421
        "EHLO p3plsmtpa11-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379715AbhCCRqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:46:02 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id HVUmlB2UCysOoHVUmlpJsP; Wed, 03 Mar 2021 10:41:13 -0700
X-CMAE-Analysis: v=2.4 cv=Q50XX66a c=1 sm=1 tr=0 ts=603fca39
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=rTsI85MkaD2DFeaHCx4A:9 a=QEXdDO2ut3YA:10
 a=5oRCH6oROnRZc2VpWJZ3:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [man-pages][PATCH v1] flock.2: add CIFS details
To:     =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com
Cc:     smfrench@gmail.com
References: <20210302154831.17000-1-aaptel@suse.com>
 <5ae02f1f-af45-25aa-71b1-4f8782286158@talpey.com> <8735xcxkv5.fsf@suse.com>
 <f1beb7c8-1f73-0ea7-7052-13b6516b5f6c@talpey.com> <87zgzkw4ya.fsf@suse.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <50268813-b6cd-8959-26a9-79ce75366c64@talpey.com>
Date:   Wed, 3 Mar 2021 12:41:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <87zgzkw4ya.fsf@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHo6Q74mDvowcGKiwdTMTE7yxk9Y4AJDvJ3lmuR200BrV34EqvoMKLg2nqIh2RCwmfKBp/7Quj15N+dRQJu5Vlq01lhpjjl7RfL5n4VN6fn2XVtYdedg
 NxxT3ermjZBhp+CLCTHj2fwPzn/p8X2FE+twP4oV8mI4srwVvZazs9XVbYOW1avBaP6UKvBeMM+IDVOT5AG9XCOLOMAw+46iiQc4TBPNn5tJqAoI+GOutd7I
 3sdobejCifY82+VV1FcXFSYrHtUPgDn5Fa6/EgJBhlVFiEgwQBi0OQidwZrCxwa0fMuxThD9l8E156So4enHAwG+un4FL0ZoP3B9lWCgYjRjKCzC7I7NQUqW
 sSUu+tlD
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/3/2021 11:57 AM, Aurélien Aptel wrote:
> Tom Talpey <tom@talpey.com> writes:
>> I don't fully understand your response. What does "knows about syscall
>> from local apps" mean, from a practical perspective? That it never
>> forwards any flock() call to the server? Or that it somehow caches
>> the flock() results, and never checks if the server has a conflict
>> from another client?
> 
> Yes that's what I'm trying to say. Locking never goes on the
> wire. Server is not aware of locking, and thus neither are any other
> clients.

Ok, but that's what I wrote in the earlier suggestion:

"In Linux kernels up to 5.4, flock() is not propagated over SMB. A file
with such locks will not appear locked for remote clients."

So I'm still confused what to suggest, but I'll respond on the
other fork of the thread.

Tom.
