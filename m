Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03526A19F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 14:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfH2MZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 08:25:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:34498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726214AbfH2MZu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:25:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56426AFB6;
        Thu, 29 Aug 2019 12:25:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 50F8C1E3BE6; Thu, 29 Aug 2019 14:25:48 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Steve Magnani <steve.magnani@digidescorp.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] udf: Verify domain identifier
Date:   Thu, 29 Aug 2019 14:25:41 +0200
Message-Id: <20190829122543.22805-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

These two patches make udf verify domain identifier and honor write protection
fields in domain identifier suffix for logical volume descriptor and fileset
descriptor. Steve, can you verify the patch works for the media you've spotted?
It worked fine for the images I had laying around. Thanks!

								Honza
