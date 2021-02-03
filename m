Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D601230DFC5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 17:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhBCQc1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 11:32:27 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48832 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231571AbhBCQcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:32:24 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 113GVSIH004657
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 Feb 2021 11:31:29 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 76B1C15C39E2; Wed,  3 Feb 2021 11:31:28 -0500 (EST)
Date:   Wed, 3 Feb 2021 11:31:28 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com, Paul Lawrence <paullawrence@google.com>
Subject: Re: [PATCH 1/2] ext4: Handle casefolding with encryption
Message-ID: <YBrP4NXAsvveIpwA@mit.edu>
References: <20210203090745.4103054-2-drosen@google.com>
 <56BC7E2D-A303-45AE-93B6-D8921189F604@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56BC7E2D-A303-45AE-93B6-D8921189F604@dilger.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 03, 2021 at 03:55:06AM -0700, Andreas Dilger wrote:
> 
> It looks like this change will break the dirdata feature, which is similarly
> storing a data field beyond the end of the dirent. However, that feature also
> provides for flags stored in the high bits of the type field to indicate
> which of the fields are in use there.
> The first byte of each field stores
> the length, so it can be skipped even if the content is not understood.

Daniel, for context, the dirdata field is an out-of-tree feature which
is used by Lustre, and so has fairly large deployed base.  So if there
is a way that we can accomodate not breaking dirdata, that would be
good.

Did the ext4 casefold+encryption implementation escape out to any
Android handsets?

Thanks,

					- Ted
