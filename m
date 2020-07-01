Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FED210AD0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 14:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbgGAMNs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 08:13:48 -0400
Received: from verein.lst.de ([213.95.11.211]:39980 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730271AbgGAMNr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:13:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C61FA68B02; Wed,  1 Jul 2020 14:13:44 +0200 (CEST)
Date:   Wed, 1 Jul 2020 14:13:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [fs] 140402bab8: stress-ng.splice.ops_per_sec -100.0%
 regression
Message-ID: <20200701121344.GA14149@lst.de>
References: <20200624161335.1810359-14-hch@lst.de> <20200701091943.GC3874@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701091943.GC3874@shao2-debian>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FYI, this is because stress-nh tests splice using /dev/null.  Which
happens to actually have the iter ops, but doesn't have explicit
splice_read operation.
