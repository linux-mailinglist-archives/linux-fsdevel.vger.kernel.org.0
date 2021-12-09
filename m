Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D1146F3CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Dec 2021 20:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhLITUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Dec 2021 14:20:54 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55922 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229379AbhLITUx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:20:53 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-106.corp.google.com [104.133.8.106] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B9JHC5t026548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Dec 2021 14:17:14 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5D4364205DB; Thu,  9 Dec 2021 14:17:11 -0500 (EST)
Date:   Thu, 9 Dec 2021 14:17:11 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v4 00/13] ext4: new mount API conversion
Message-ID: <YbJWN+6nmhpQOZR1@mit.edu>
References: <20211027141857.33657-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027141857.33657-1-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Lukas,

I'm starting to process ext4 patches for the next merge window, and I
want to pull in the merge mount API conversions as one of the first
patches into the dev tree.

Should I use the v4 patch set or do you have a newer set of changes
that you'd like me to use?  There was a minor patch conflict in patch
#2, but that was pretty simple to fix up.

Thanks!

						- Ted
