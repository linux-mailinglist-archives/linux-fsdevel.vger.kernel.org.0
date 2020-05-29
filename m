Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F6F1E752F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 07:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE2FG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 01:06:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:46238 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2FG0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 01:06:26 -0400
IronPort-SDR: 2GmVc1UI52QIDj59OI6f8Fuu/MNOhhfILS88iJyYObOxzl+Zr7eCmyds/81GrIzxs8wXr2HLTU
 07xq6QEyJq1Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 22:06:25 -0700
IronPort-SDR: Q378vlAV+5CbbfwgiLK3pPtw6LQwoo8drUIOmgXm7VswzoX2a1rN/wOv2n9dXGJGsZ/HvqPI4O
 L/mpkgwofyHg==
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="443244518"
Received: from vtsikino-mobl.ger.corp.intel.com (HELO localhost) ([10.249.43.186])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 22:06:17 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCHES] uaccess i915
In-Reply-To: <20200529004050.GY23230@ZenIV.linux.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200528234025.GT23230@ZenIV.linux.org.uk> <20200529004050.GY23230@ZenIV.linux.org.uk>
Date:   Fri, 29 May 2020 08:06:14 +0300
Message-ID: <87ftbj1gah.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 29 May 2020, Al Viro <viro@zeniv.linux.org.uk> wrote:
> 	Low-hanging fruit in i915 uaccess-related stuff.
> There's some subtler stuff remaining after that; these
> are the simple ones.

Please Cc: intel-gfx@lists.freedesktop.org for i915 changes.

Also added Chris who I believe will be able to best review the changes.


BR,
Jani.




-- 
Jani Nikula, Intel Open Source Graphics Center
