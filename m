Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722C8356D59
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245009AbhDGNcq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 09:32:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235738AbhDGNco (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:32:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFA02601FB;
        Wed,  7 Apr 2021 13:32:32 +0000 (UTC)
Date:   Wed, 7 Apr 2021 15:32:30 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michal Hocko <mhocko@suse.com>, stgraber@ubuntu.com
Cc:     Bharata B Rao <bharata@linux.ibm.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, aneesh.kumar@linux.ibm.com
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <20210407133230.6slrpyjjfrc34s7u@wittgenstein>
References: <20210405054848.GA1077931@in.ibm.com>
 <YG2diKMPNSK2cMyG@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YG2diKMPNSK2cMyG@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 01:54:48PM +0200, Michal Hocko wrote:
> On Mon 05-04-21 11:18:48, Bharata B Rao wrote:
> > Hi,
> > 
> > When running 10000 (more-or-less-empty-)containers on a bare-metal Power9
> > server(160 CPUs, 2 NUMA nodes, 256G memory), it is seen that memory
> > consumption increases quite a lot (around 172G) when the containers are
> > running. Most of it comes from slab (149G) and within slab, the majority of
> > it comes from kmalloc-32 cache (102G)
> 
> Is this 10k cgroups a testing enviroment or does anybody really use that
> in production? I would be really curious to hear how that behaves when
> those containers are not idle. E.g. global memory reclaim iterating over
> 10k memcgs will likely be very visible. I do remember playing with
> similar setups few years back and the overhead was very high.

Ccing Stéphane Graber who has experience/insight about stuff like this.

Christian
