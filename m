Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04286187B36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 09:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgCQI2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 04:28:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:15232 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgCQI2b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:28:31 -0400
IronPort-SDR: L+wOpw7Il/Ya190YYDNNlQMOn7UllIZCQ8dXXTUlYPe3aOJvRLEPp+nCvVvfVW8o1pDmZk+WWu
 1O6JNQhljKXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 01:28:31 -0700
IronPort-SDR: healM5eFWf/Kw6gBx4FVqQaJZugrClmjQKDXhbzYDs3BBjEOxoAnAMbVR9ke5InzTm6fiaOhDa
 EEpQ9MKjRDYw==
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; 
   d="scan'208";a="390985809"
Received: from bquerbac-mobl1.amr.corp.intel.com (HELO localhost) ([10.135.40.52])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 01:28:28 -0700
From:   "Patrick Ohly" <patrick.ohly@intel.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
Subject: Re: [PATCH 00/20] virtiofs: Add DAX support
In-Reply-To: <20200316130234.GA4013@redhat.com>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
References: <20200304165845.3081-1-vgoyal@redhat.com> <yrjh1rpzggg4.fsf@pohly-mobl1.fritz.box> <20200316130234.GA4013@redhat.com>
Date:   Tue, 17 Mar 2020 09:28:26 +0100
Message-ID: <yrjhlfnzcrmd.fsf@pohly-mobl1.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:
> We expect users will issue fsync/msync like a regular filesystem to
> make changes persistent. So in that aspect, rejecting MAP_SYNC
> makes sense. I will test and see if current code is rejecting MAP_SYNC
> or not.

Last time I checked, it did. Here's the test program that I wrote for
that:
https://github.com/intel/pmem-csi/blob/ee3200794a1ade49a02df6f359a134115b409e90/test/cmd/pmem-dax-check/main.go

-- 
Best Regards

Patrick Ohly
