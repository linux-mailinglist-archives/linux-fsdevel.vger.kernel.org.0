Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 241D66D72F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 01:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfGRXRy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 19:17:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53880 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbfGRXRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 19:17:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hoFeq-0002m1-6a; Thu, 18 Jul 2019 23:17:52 +0000
Date:   Fri, 19 Jul 2019 00:17:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Benjamin LaHaise <bcrl@kvack.org>, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: Support read/write with non-iter file-ops
Message-ID: <20190718231751.GV17978@ZenIV.linux.org.uk>
References: <20190718231054.8175-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718231054.8175-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 18, 2019 at 04:10:54PM -0700, Bjorn Andersson wrote:
> Implement a wrapper for aio_read()/write() to allow async IO on files
> not implementing the iter version of read/write, such as sysfs. This
> mimics how readv/writev uses non-iter ops in do_loop_readv_writev().

IDGI.  How would that IO manage to be async?  And what's the point
using aio in such situations in the first place?
