Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741151E63A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 16:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391018AbgE1OU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 10:20:58 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45277 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390924AbgE1OU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 10:20:56 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04SEKlID019537
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 10:20:48 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 42429420304; Thu, 28 May 2020 10:20:47 -0400 (EDT)
Date:   Thu, 28 May 2020 10:20:47 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC 00/16] ext4: mballoc/extents: Code cleanup and debug
 improvements
Message-ID: <20200528142047.GD228632@mit.edu>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1589086800.git.riteshh@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 10, 2020 at 11:54:40AM +0530, Ritesh Harjani wrote:
> Hello All,
> 
> This series does some code refactoring/cleanups and debug logs improvements
> around mb_debug() and ext_debug(). These were found when working over
> improving mballoc ENOSPC handling in ext4.
> These should be small and stright forward patches for reviewing.

I've applied all but the last patch ("Add process namd and pid in
ext4_msg"), which I think needs a bit more discussion.

	    	    	  	      - Ted
