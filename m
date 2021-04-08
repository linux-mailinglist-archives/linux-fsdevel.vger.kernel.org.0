Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084F4357D9E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 09:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhDHHve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 03:51:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhDHHve (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:51:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96FD661155;
        Thu,  8 Apr 2021 07:51:20 +0000 (UTC)
Date:   Thu, 8 Apr 2021 09:51:17 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, hannes@cmpxchg.org,
        yhs@fb.com
Subject: Re: [RFC bpf-next 0/1] bpf: Add page cache iterator
Message-ID: <20210408075117.oqoqspilk3c3xsaa@wittgenstein>
References: <cover.1617831474.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617831474.git.dxu@dxuuu.xyz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 02:46:10PM -0700, Daniel Xu wrote:
> There currently does not exist a way to answer the question: "What is in
> the page cache?". There are various heuristics and counters but nothing
> that can tell you anything like:
> 
>   * 3M from /home/dxu/foo.txt
>   * 5K from ...
>   * etc.
> 
> The answer to the question is particularly useful in the stacked
> container world. Stacked containers implies multiple containers are run
> on the same physical host. Memory is precious resource on some (if not

Just to clarify: what are "stacked containers"? Do you mean nested
containers, i.e. containers running within containers?

Christian
