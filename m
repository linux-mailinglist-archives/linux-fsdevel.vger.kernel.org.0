Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290C523AA8C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgHCQeq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 12:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHCQep (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:34:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF53C06174A;
        Mon,  3 Aug 2020 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=16ecIfKYTC6wA0DdewyyTEigHELGFn55FwwngqqMb48=; b=ZX1YfeI+UTqupGHYcevoIHrxnX
        S99QlFQhbTDmeGpKj+bDeoA9VVtzf+xI02TbV/C1JyQuYz8CEdH3NeOAaRfohAxcO9vIiFJmIxGLx
        +f31Ws3bI2wpDkWLsWKit3Vega/7/vwgl7kN5jiTZaYeSaIsvfYE+vdqWqUZrSnTCr2ZzD+SjEFRt
        AczXQuwbJDucOp/L17S5/yFNAhbN9YnNm3S39i8+2YyBiuOI1WiVojYJK+rnEYMGRbyPwFWT//mXo
        b9/unNrPWJMJovAz5l1cxHtnQoVZk6fF1mv6pltctOjb8fzvChuERjpiKpUb0pXZM2RfvUQFH5+Es
        Py+ysuBQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2dPx-0003zS-JQ; Mon, 03 Aug 2020 16:34:29 +0000
Date:   Mon, 3 Aug 2020 17:34:29 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-fsdevel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Ioannis Ilkos <ilkos@google.com>,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com
Subject: Re: [PATCH 1/2] fs: Add fd_install file operation
Message-ID: <20200803163429.GA15200@infradead.org>
References: <20200803144719.3184138-1-kaleshsingh@google.com>
 <20200803144719.3184138-2-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803144719.3184138-2-kaleshsingh@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 03, 2020 at 02:47:18PM +0000, Kalesh Singh wrote:
> Provides a per process hook for the acquisition of file descriptors,
> despite the method used to obtain the descriptor.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

I strongly disagree with this.  The file operation has no business
hooking into installing the fd.
