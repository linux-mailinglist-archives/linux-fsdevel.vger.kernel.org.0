Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EAC48DD24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 18:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbiAMRvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 12:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiAMRvC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:51:02 -0500
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FC6C061574;
        Thu, 13 Jan 2022 09:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-ID:Cc:To:From:Date;
        bh=CNaJaJCmLDp4zjhKf+vfOZmV8TnPhZwBnI3AdU8wd4E=; b=MT3Y1MSajJXlnSVfhVIkWRxFI/
        S1R3sqPvTgeTTwIHIKwTXYR5EUfhoAh2Bmstgz3ljsVXk6X+d8/5npIB+eAbF02uj76UqndpkxWxz
        AXDZ5qtx3mAXwCoqwrX/I96p++rUwdrClC6NYuhJhAQSSt4uH5E9vPCzQdXyC0i3CZg1FsrB/iJiq
        1Mcn6kXO/lmq8mv2obVuQu0haRmHHrobGbTOYtNdGNowwhK8RmoCDVa4r0v+LGGayrcQoNwDh8TZc
        ulB+w80Wljy6zAFGRUyBNcOrzmRexjR0zh4QOEYFvNmTRFL7gsVHBuM/UewAsEi9VdukSssG8Xbp0
        SJDGz0IZyKXS/4paRUPtQ3HXw08GgHiZy7CpHdJluLhsZ9JicLxbi+dgHyazcw0LOfJSjYr3gqj1B
        I0cPSEbVLjITGprzMlZXhKIgkRK27NXQtg5tslZSby8+3Q7LvSYTQMoiLYimfMJNGMbG0y21qhXCB
        nT3v/RBhhCSrhnN9+0cpmUqH;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1n84FM-0078Sr-Tp; Thu, 13 Jan 2022 17:50:49 +0000
Date:   Thu, 13 Jan 2022 09:50:44 -0800
From:   Jeremy Allison <jra@samba.org>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "amir73il@gmail.com" <amir73il@gmail.com>,
        Lance Shelton <Lance.Shelton@hammerspace.com>,
        Richard Sharpe <Richard.Sharpe@hammerspace.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "hch@infradead.org" <hch@infradead.org>,
        "almaz.alexandrovich@paragon-software.com" 
        <almaz.alexandrovich@paragon-software.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "slow@samba.org" <slow@samba.org>,
        "sfrench@samba.org" <sfrench@samba.org>
Subject: Re: [bug report] NFS: Support statx_get and statx_set ioctls
Message-ID: <YeBmdHzvSlIIwmIM@jeremy-acer>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20220111074309.GA12918@kili>
 <Yd1ETmx/HCigOrzl@infradead.org>
 <CAOQ4uxg9V4Jsg3jRPnsk2AN7gPrNY8jRAc87tLvGW+TqH9OU-A@mail.gmail.com>
 <20220112174301.GB19154@magnolia>
 <CAOQ4uxh7wpxx2H6Vpm26OdigXbWCCLO1xbFapupvLCn8xOiL=w@mail.gmail.com>
 <Yd/HIYsCBPH5jPmS@jeremy-acer>
 <3cf76cc19f12f3e9da2eae7fe12e2719c8e499f8.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3cf76cc19f12f3e9da2eae7fe12e2719c8e499f8.camel@hammerspace.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 13, 2022 at 02:58:19PM +0000, Trond Myklebust wrote:
>On Wed, 2022-01-12 at 22:30 -0800, Jeremy Allison wrote:
>> On Thu, Jan 13, 2022 at 05:52:40AM +0200, Amir Goldstein wrote:
>> >
>> > To add one more terminology to the mix - when Samba needed to cope
>> > with these two terminologies they came up with itime for
>> > "instantiation time"
>> > (one may also consider it "immutable time").
>>
>> No, that's not what itime is. It's used as the basis
>> for the fileid return as MacOSX clients insist on no-reuse
>> of inode numbers when a file is deleted then re-created,
>> and ext4 will re-use the same inode.
>
>So basically it serves more or less the same purpose as the generation
>counter that most Linux filesystems use in the filehandle to provide
>similar only-once semantics?

Kind of, although we moved it recently to be
a current_time + random skew as the timestamp
resolution in ext4 just wasn't enough to get us
unique fileids.
