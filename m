Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85A833C880
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 22:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhCOVdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 17:33:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:28452 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232883AbhCOVdZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 17:33:25 -0400
IronPort-SDR: 5E8fHKcgBEs90/lBjBFLTtf7c0XdhT5LGUItS6TZE3KfuvyPm8lOzZ9eH3VPkxdy7fHRIz9G1M
 RsgU/wH1T2QA==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="176289568"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="176289568"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 14:33:19 -0700
IronPort-SDR: Pk1FndYUaxQ7Ke1uG7YYuOB7UtQuuc/wyxhIUVI7L60/MLxN6D5uHsnxT4gndfygNwNp7w8+V2
 SFuNVn4p6efA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="432793325"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.74.11])
  by fmsmga004.fm.intel.com with ESMTP; 15 Mar 2021 14:33:17 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 57F893023AF; Mon, 15 Mar 2021 14:33:17 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/25] Page folios
References: <20210305041901.2396498-1-willy@infradead.org>
        <20210313123658.ad2dcf79a113a8619c19c33b@linux-foundation.org>
        <alpine.LSU.2.11.2103131842590.14125@eggly.anvils>
        <20210315115501.7rmzaan2hxsqowgq@box>
        <YE9VLGl50hLIJHci@dhcp22.suse.cz>
Date:   Mon, 15 Mar 2021 14:33:17 -0700
In-Reply-To: <YE9VLGl50hLIJHci@dhcp22.suse.cz> (Michal Hocko's message of
        "Mon, 15 Mar 2021 13:38:04 +0100")
Message-ID: <87sg4wumoy.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:
> bikeshedding) because it hasn't really resonated with the udnerlying
> concept. Maybe just me as a non native speaker... page_head would have
> been so much more straightforward but not something I really care
> about.

Yes. page_head explains exactly what it is.

But Folio? Huh?

-Andi

