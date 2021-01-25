Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EAD30499E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbhAZF0R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:26:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbhAYSms (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:42:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07A5A230FF;
        Mon, 25 Jan 2021 18:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611600113;
        bh=BcQjpfINfveQmERew10h4a0n6dN8EsCa5I5lsAkb6Uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qisl3plDrCd6OrPM4RX01TZ3EzRVZhIIPqBvHsMU53MkaYfxvUrLMMHNJjTnFHqBT
         tjxUPpYruIOFMXnbKbEymBeQIUOepUclZLvugJfkFZvVa/A3ngMw7W5V4eBOAF/RDV
         siJKR4b4zuOFcB+BSX7G4VbVlna5M+qfEwOoSkYEb3V7I7AjHuVC8Yz5iVshQ6H850
         XQXewvlYPcHUIYFplER/X1iD3GkzAK89IibAPUjuUDLP4H9IbLKlbA13f/OGkTJNkq
         qBqFGHMZozKrQY/hicThNo7ZOqu7H651159DR5T626+ks2I4/+SyZFE8CXknWOHxGo
         S0AP3otBlibjw==
Date:   Mon, 25 Jan 2021 10:41:45 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Victor Hsieh <victorhsieh@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-api@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 0/6] fs-verity: add an ioctl to read verity metadata
Message-ID: <YA8Q6XLrLaaeMQeJ@sol.localdomain>
References: <20210115181819.34732-1-ebiggers@kernel.org>
 <CAFCauYN12bWRn2N+uP455KuRmz7CQkCBXnz0B2sr5kCQtpJo4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCauYN12bWRn2N+uP455KuRmz7CQkCBXnz0B2sr5kCQtpJo4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 22, 2021 at 03:26:48PM -0800, Victor Hsieh wrote:
> LGTM. Thanks!
> 
> Reviewed-by: Victor Hsieh <victorhsieh@google.com>
> 
> On Fri, Jan 15, 2021 at 10:19 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > [This patchset applies to v5.11-rc3]
> >
> > Add an ioctl FS_IOC_READ_VERITY_METADATA which allows reading verity
> > metadata from a file that has fs-verity enabled, including:

Thanks Victor.  Does anyone else have comments on this patchset?

- Eric
