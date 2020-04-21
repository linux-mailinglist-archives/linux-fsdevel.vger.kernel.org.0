Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1143A1B327D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 00:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgDUWIT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 18:08:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:35600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgDUWIS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:08:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 475F2ACD0;
        Tue, 21 Apr 2020 22:08:17 +0000 (UTC)
Date:   Tue, 21 Apr 2020 17:08:14 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Missing fs_param_v_optional implementation
Message-ID: <20200421220814.x4akncbkwls33452@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

While reading the documentation of fs_context, I realized implementation
of fs_param_v_optional is missing. Also, fs_param_neg_with_empty is unused.
Is this a miss or is there more work coming?

-- 
Goldwyn
