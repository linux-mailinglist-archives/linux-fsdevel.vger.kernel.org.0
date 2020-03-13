Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE80A184FAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 20:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgCMTy2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 15:54:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57256 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgCMTy2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:54:28 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02DJqlEP027130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 15:52:48 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 54B2A420E5E; Fri, 13 Mar 2020 15:52:47 -0400 (EDT)
Date:   Fri, 13 Mar 2020 15:52:47 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com
Subject: Re: [PATCHv5 1/6] ext4: Add IOMAP_F_MERGED for non-extent based
 mapping
Message-ID: <20200313195247.GH225435@mit.edu>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <a4764c91c08c16d4d4a4b36defb2a08625b0e9b3.1582880246.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4764c91c08c16d4d4a4b36defb2a08625b0e9b3.1582880246.git.riteshh@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:56:54PM +0530, Ritesh Harjani wrote:
> IOMAP_F_MERGED needs to be set in case of non-extent based mapping.
> This is needed in later patches for conversion of ext4_fiemap to use iomap.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
