Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83FF41E7FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 09:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352311AbhJAHID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 03:08:03 -0400
Received: from out2.migadu.com ([188.165.223.204]:23678 "EHLO out2.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352289AbhJAHIC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 03:08:02 -0400
Date:   Fri, 1 Oct 2021 16:06:11 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633071978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ymD0se4e0gF69/42SfmiuruO6Ev4hFG0QF/xv+bO0Yw=;
        b=eIDCy4NdPH3C7VW8G+FtOtnUjeJiefBclroB/5Ce1H8lKTi++ojwbJyxFocb2TD/Jursb7
        klRDDB6RmFkmlYrwk6RPgefEixi9bll/El+V/VbOgnoB/YOuFN9X2xLlIg+TRxn1njDZll
        0iKtUu0wZvE1Ytx+W3QP2pR9l32R/P0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 5/5] mm: hwpoison: handle non-anonymous THP correctly
Message-ID: <20211001070611.GB1364952@u2004>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-6-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210930215311.240774-6-shy828301@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 02:53:11PM -0700, Yang Shi wrote:
> Currently hwpoison doesn't handle non-anonymous THP, but since v4.8 THP
> support for tmpfs and read-only file cache has been added.  They could
> be offlined by split THP, just like anonymous THP.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
