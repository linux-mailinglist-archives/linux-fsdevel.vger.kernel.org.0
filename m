Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2244163B1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 18:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242331AbhIWQ4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 12:56:30 -0400
Received: from kanga.kvack.org ([205.233.56.17]:45554 "EHLO kanga.kvack.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240732AbhIWQ4U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:56:20 -0400
X-Greylist: delayed 1025 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Sep 2021 12:56:20 EDT
Received: by kanga.kvack.org (Postfix, from userid 63042)
        id 3C79E900002; Thu, 23 Sep 2021 12:37:43 -0400 (EDT)
Date:   Thu, 23 Sep 2021 12:37:43 -0400
From:   Benjamin LaHaise <ben@communityfibre.ca>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH v2] aio: convert active_reqs into a hashtable
Message-ID: <20210923163743.GZ24576@kvack.org>
References: <20210919144146.19531-1-someguy@effective-light.com> <20210919145645.GE16005@kvack.org> <7H1WZQ.H8D3XK8HUSNQ3@effective-light.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7H1WZQ.H8D3XK8HUSNQ3@effective-light.com>
User-Agent: Mutt/1.4.2.2i
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 09:00:43AM -0400, Hamza Mahfooz wrote:
> Would that not mean that, we would have to keep track of the indices of 
> the
> array that are not being held by an `aio_kiocb`?

Correct.  This is a better solution than the hash table and would mean
that the requests list could likely be replaced by the table.

		-ben
-- 
"Thought is the essence of where you are now."
