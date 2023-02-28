Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2836A5F17
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 19:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjB1S6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 13:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjB1S6b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:58:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DD91E9DB;
        Tue, 28 Feb 2023 10:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ODWpsUYOiXhTNb085YfE8+7niJYCkg4/3V/Dygz4pW4=; b=f7U74J/t4GKsjYf9Pdpm7xB30A
        zd+MKYYlyIA84bT/Cq/lzP7GTJmN5YGwraY/HTUvWRJ5S44vx9p7Ody/2+3pl2Vfgxw6ZvyRDQ71X
        SQjPIptHglbVjnGdimS57MDHAyQFHmgwn8V7U3E6FdnU9DtSLUJwiUTAANO6lifYngrvmBK6rm/LM
        Bcc87QEqrOkAEGR2PHaN+kR70FS5wmDqYCmDXx6lOBRnC7BXG2EWAcLUwjeNZixT24nIz/jaRu565
        AQg6QszZIb6hpaV9L7w3+4uqrQ3fZNpBIXBQSoDlVj0S0xYi0Iv2PZ7SDncVrZ6wLto7DyLlKApUJ
        UCl0D+og==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX5BD-00E21Q-VG; Tue, 28 Feb 2023 18:58:27 +0000
Date:   Tue, 28 Feb 2023 10:58:27 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-cxl@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>, code@tyhicks.com,
        sfrench@samba.org, jlayton@kernel.org, chandan.babu@oracle.com,
        josef@toxicpanda.com, amir73il@gmail.com, palmer@dabbelt.com,
        dave@stgolabs.net, a.manzanares@samsung.com, fan.ni@samsung.com
Subject: Re: kdevops live demo zoom & Q&A
Message-ID: <Y/5O0yItfBwNKdXm@bombadil.infradead.org>
References: <Y/1KnN/ER8pnhbaa@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/1KnN/ER8pnhbaa@bombadil.infradead.org>
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

On Mon, Feb 27, 2023 at 04:28:12PM -0800, Luis Chamberlain wrote:
> To start off with let me propose a few dates for this zoom demo (all
> are Wednesdays as its my most flexible day):
> 
>   * March 8  1pm PST
>   * March 15 1pm PST
>   * March 29 1pm PST

Based on feedback to at least to get some EU folks I'll change this to 9am PST.
I know one person can't attend March 8th so the following dates are
remaining:

* March 15 9am PST
* March 29 9am PST

Let me know if this works for those who had expressed interest.

  Luis
