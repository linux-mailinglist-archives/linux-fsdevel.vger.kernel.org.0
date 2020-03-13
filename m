Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9A5184FE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 21:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgCMUF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 16:05:58 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60128 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726591AbgCMUF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:05:58 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02DK5fWp031917
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 16:05:42 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C1EA6420E5E; Fri, 13 Mar 2020 16:05:40 -0400 (EDT)
Date:   Fri, 13 Mar 2020 16:05:40 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com
Subject: Re: [PATCHv5 2/6] ext4: Optimize ext4_ext_precache for 0 depth
Message-ID: <20200313200540.GI225435@mit.edu>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <93da0d0f073c73358e85bb9849d8a5378d1da539.1582880246.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93da0d0f073c73358e85bb9849d8a5378d1da539.1582880246.git.riteshh@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:56:55PM +0530, Ritesh Harjani wrote:
> This patch avoids the memory alloc & free path when depth is 0,
> since anyway there is no extra caching done in that case.
> So on checking depth 0, simply return early.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
