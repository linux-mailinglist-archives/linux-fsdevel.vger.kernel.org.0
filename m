Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E3F36EF99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 20:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbhD2Sl3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 14:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbhD2Sl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:41:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A080C06138B;
        Thu, 29 Apr 2021 11:40:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 15E9B1F4366D
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Subject: Re: [PATCH RFC 10/15] fanotify: Introduce code location record
Organization: Collabora
References: <20210426184201.4177978-1-krisman@collabora.com>
        <20210426184201.4177978-11-krisman@collabora.com>
        <CAOQ4uxh_AQCj2XJgVzFp862xhr70FAS6n3QjeeQSd_bizw3Ssw@mail.gmail.com>
Date:   Thu, 29 Apr 2021 14:40:37 -0400
In-Reply-To: <CAOQ4uxh_AQCj2XJgVzFp862xhr70FAS6n3QjeeQSd_bizw3Ssw@mail.gmail.com>
        (Amir Goldstein's message of "Tue, 27 Apr 2021 10:11:12 +0300")
Message-ID: <87lf9153yy.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Mon, Apr 26, 2021 at 9:43 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>>
>> This patch introduces an optional info record that describes the
>> source (as in the region of the source-code where an event was
>> initiated).  This record is not produced for other type of existing
>> notification, but it is optionally enabled for FAN_ERROR notifications.
>>
>
> I find this functionality controversial, because think that the fs provided
> s_last_error*, s_first_error* is more reliable and more powerful than this
> functionality.
>
> Let's leave it for a future extending proposal, should fanotify event reporting
> proposal pass muster, shall we?
> Or do you think that without this optional extension fanotify event reporting
> will not be valuable enough?

I think it is valuable enough without this bit, at least on a first
moment.  I understand it would be useful for ext4 to analyse information
through this interface, but the main priority is to have a way to push
out the information that an error occured, as you mentioned.

Also, this might be more powerful if we stick to the ring buffer instead
of single stlot, as it would allow more data to be collected than just
first/last.
>
> Thanks,
> Amir.

-- 
Gabriel Krisman Bertazi
