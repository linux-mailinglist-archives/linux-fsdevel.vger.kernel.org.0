Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F3F172C66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 00:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgB0Xk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 18:40:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50164 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbgB0Xk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:40:57 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7Slz-0027E7-Iv; Thu, 27 Feb 2020 23:40:55 +0000
Date:   Thu, 27 Feb 2020 23:40:55 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] exec: remove comparision of variable i_size of type
 loff_t against SIZE_MAX
Message-ID: <20200227234055.GF23230@ZenIV.linux.org.uk>
References: <20200227233133.10383-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227233133.10383-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 03:31:33PM -0800, Scott Branden wrote:
> Remove comparision of (i_size > SIZE_MAX).
> i_size is of type loff_t and can not be great than SIZE_MAX (~(size_t)0).

include/linux/types.h:46:typedef __kernel_loff_t                loff_t;
include/uapi/asm-generic/posix_types.h:88:typedef long long     __kernel_loff_t;

And boxen with size_t smaller than long long do exist.  Anything
32bit will qualify.  Pick any such and check that yourself...
