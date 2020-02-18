Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDCDE1626C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 14:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgBRNE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 08:04:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:49568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgBRNE7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:04:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A54CDB297;
        Tue, 18 Feb 2020 13:04:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DAE34DA7BA; Tue, 18 Feb 2020 14:04:40 +0100 (CET)
Date:   Tue, 18 Feb 2020 14:04:39 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 03/44] docs: filesystems: convert affs.txt to ReST
Message-ID: <20200218130439.GK2902@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
 <b44c56befe0e28cbc0eb1b3e281ad7d99737ff16.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b44c56befe0e28cbc0eb1b3e281ad7d99737ff16.1581955849.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 05:11:49PM +0100, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Adjust document title;
> - Add table markups;
> - Mark literal blocks as such;
> - Some whitespace fixes and new line breaks;
> - Add it to filesystems/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: David Sterba <dsterba@suse.com>
