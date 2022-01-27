Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858F049D7E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 03:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbiA0COP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 21:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiA0COO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:14:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D91C06161C;
        Wed, 26 Jan 2022 18:14:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0264D60B56;
        Thu, 27 Jan 2022 02:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33834C340E7;
        Thu, 27 Jan 2022 02:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643249653;
        bh=TR7elGJCW4/+5+wp++QAcw0FIPXxPqFbQcGAZOUcs6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7NCm+QxP3qtsyLEWzYQMXvcwEUwEa3ymsN1AAKOX72yZWQKNHtyABC6VSEgXYQiG
         /CIqF4tMlf3S810Xpe14LsuM7++u418VTqUSmHUAeFx8KkoN6rmtU72ZFQnWich3rh
         83UHFrvD9VqAl/44QXNauU29yvaof1ySWsKaGcEI/WtTKT/Dw0Ql30i8bEWXvoqneo
         rYEmx1mV14v8a6xVIM9vMBuYQ+WTXDZhLWv8egSN6xFt1qxVh/l67db6ehgSPtJyNl
         vnAf2V1wJcrsg66nyCJ/ImR0/63HVYB5OzySGt0WEEwzet3xWldyaZ+SOyotzhoRQm
         ZMz71KtLe+QcQ==
Date:   Wed, 26 Jan 2022 18:14:11 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: Re: [RFC PATCH v10 00/48] ceph+fscrypt: full support
Message-ID: <YfH/8xCAtyCA9raH@sol.localdomain>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 11, 2022 at 02:15:20PM -0500, Jeff Layton wrote:
> Still, I was able to run xfstests on this set yesterday. Bug #2 above
> prevented all of the tests from passing, but it didn't oops! I call that
> progress! Given that, I figured this is a good time to post what I have
> so far.

One question: what sort of testing are you doing to show that the file contents
and filenames being stored (i.e., sent by the client to the server in this case)
have been encrypted correctly?  xfstests has tests that verify this for block
device based filesystems; are you doing any equivalent testing?

- Eric
