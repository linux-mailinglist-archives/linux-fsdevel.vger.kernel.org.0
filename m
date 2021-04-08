Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A3C357930
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 02:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhDHAwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 20:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhDHAwo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 20:52:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE5ED611C1;
        Thu,  8 Apr 2021 00:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617843152;
        bh=0IqB+o5pa4cpP+r10TYU8b1OpH+60OMa+LdDlFSSCM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2r/GaunjIWONcwRT1lMgR7osxHYWBpPEZDHV4yjK3NopxXoDK66FDXcLJnabeevk
         KSZAt6H6VVm5eToznjaloTdlE0n1lEJ0q1F+7Cwl2b59JrQOXsM8yq5TX6S9C7aebP
         Ul2EutKg1X9UwTMXc2MF04N2WCuBnTF+F6cQ3y/lD91tFi8CYpAEY8vxtqayzY/sY8
         dkdOXu+mRQbGtwaB85nTOqK7J6aWu8AwvxP1ejIN5v8i9SxJEsEPHlbyOHGUYcX2R4
         YddI6pEgJ/hgNGk0uE3CmXX8b70Nyjh4pE9IxcpgRzj4s3G/ls75vJWuqJg/WZuaph
         CKzr5887DS28A==
Date:   Wed, 7 Apr 2021 17:52:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, krisman@collabora.com, drosen@google.com,
        yuchao0@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        andre.almeida@collabora.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 1/4] fs: unicode: Use strscpy() instead of strncpy()
Message-ID: <YG5TzqDwHXxvlvz1@gmail.com>
References: <20210407144845.53266-1-shreeya.patel@collabora.com>
 <20210407144845.53266-2-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407144845.53266-2-shreeya.patel@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 08:18:42PM +0530, Shreeya Patel wrote:
> The -Wstringop-truncation warning highlights the unintended
> uses of the strncpy function that truncate the terminating NULL
> character from the source string.
> Unlike strncpy(), strscpy() always null-terminates the destination string,
> hence use strscpy() instead of strncpy().

This explanation is a bit misleading.  It would be clearer to phrase this in
terms of fixing how overly-long strings are handled: start returning an error
instead of creating a non-null-terminated string.

> 
> Fixes: 9d53690f0d4e5 (unicode: implement higher level API for string handling)

There should be quotes around the commit title here.

- Eric
