Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3FA6A5023
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 01:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjB1A2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 19:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB1A2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:28:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C79BBDDE;
        Mon, 27 Feb 2023 16:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RUPtv80iasip6L+HxLH978pJ7NAFEMLpiydpQPv0g20=; b=U5fQ6RZ8vkUFHPCqrOaotham6W
        Z9WDd6DVoFOLmy5mPQvuuZPugokQedheQvenRLhvSV0I0G2RnBJiM8xRx59cQZFhzBXbqCKbII+xo
        UyHogoJPIdlUVYq8cclhc5PivBADNpOdipwELjaYId3c86GEeGIxML5XSyWTE/bBG4ucB4RVTtyyD
        UGwT9o+kyQPubObn5iHcVs6pAC6duour5xitDAPIJXWMqfMtA7+OMGHqfhCcX2xKY3TE3KmYTl8g9
        91m1q8+yvoda2YNEzxrCbP4syojBQr1kHqnW/WDyn0OvSJGCgvD8FOV8NmXOmUdZP5L8/NxrymyCH
        BoKwUXMg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWnqm-00BfAA-BI; Tue, 28 Feb 2023 00:28:12 +0000
Date:   Mon, 27 Feb 2023 16:28:12 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-cxl@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>, code@tyhicks.com,
        sfrench@samba.org, jlayton@kernel.org, chandan.babu@oracle.com,
        josef@toxicpanda.com, amir73il@gmail.com, palmer@dabbelt.com,
        dave@stgolabs.net, a.manzanares@samsung.com, fan.ni@samsung.com,
        mcgrof@kernel.org
Subject: kdevops live demo zoom & Q&A
Message-ID: <Y/1KnN/ER8pnhbaa@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At last year's LSFMM it was suggested I give a demo of kdevops so to
help folks who may want to start using it and adjust their development
or testing workflow.  I didnt' get to schedule one in for plumbers last
year due to my submission going in to the wrong queue and it being
corrected at pretty late, and for this year's Linuxcon as it was
too late (and not sure if folks who would want this demo to show up to
Linuxcon).

As I don't think its appropriate to give a demo at LSFMM I think it would be
better to just put out a feeler for interested parties on the relevant mailing
lists and then zero in on a date / time to get a 1-2 hour zoom session,
have it recorded and then uploaded on YouTube.

If you'd like to show some of the stuff you've been doing with kdevops
to others or simply help answer questions your presence would be greatly
appreciated. If you'd like to talk about some of the stuff you've added
so to help also make it easier for others to use let me know and we can
fit it in the schedule.

To start off with let me propose a few dates for this zoom demo (all
are Wednesdays as its my most flexible day):

  * March 8  1pm PST
  * March 15 1pm PST
  * March 29 1pm PST

If other times work better for folks, or if Wednesdays are are just not
going to work for you, but you'd like to attend please let me know.

  Luis
