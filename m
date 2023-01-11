Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A7B665FB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 16:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239364AbjAKPwF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 10:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239517AbjAKPvm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:51:42 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F194ABF5C;
        Wed, 11 Jan 2023 07:51:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673452259; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=PSrX0HCKrVCLkrtVReJ5AYKdUSD1N4mHXqR3vMUay8tNA3ucXtKpBMpOR6WxPA8otJHMlsntEQ8TG1ahhlYtoKwC+ZO450sHdJJqEpIAs2Z8nwgEF+beLQ2BqLame0J3HYwMrF0o/gfmQHwGeRsb9hDz4gWgBOWTzxOM0Nl5pg0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1673452259; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=PGIYJmsvItVwa4SA21sdOFO3fDcHeL/1qxeN028mnsk=; 
        b=eyMhoYAr+odAJELVzciivZMlgsFmbRK22iLyGCaTB/Cn7NNqDo+hX0407WLDX4XaF+mMIBgg0u1V6BSj2j0PUOAlDxMz1ugr/7bwSL1IqCXHlz5Xrby2o0PQsX+ij3rbCZRB88C4soEMM0hW07w8IFLWvDhbYfmMulAsQ25UYOE=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673452259;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=PGIYJmsvItVwa4SA21sdOFO3fDcHeL/1qxeN028mnsk=;
        b=Ldw/S6p8e7XH0d1wzBSmbkO8qE4BHtjwMOP7jgXqrfstlWE6rgQJriZbbnykliGV
        cG7dWpu9xRNMl9w2fPE9y+uJT26cqk+fNagnOdVLvTq6ezfUzbayFqZbqJ5K4F6ufwR
        hHDv/MgDWlEA4/v4sY7RybGO8mChGrtkooLXLnb0=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1673452248793661.4780019008354; Wed, 11 Jan 2023 21:20:48 +0530 (IST)
Date:   Wed, 11 Jan 2023 21:20:48 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "David Howells" <dhowells@redhat.com>
Cc:     "mauro carvalho chehab" <mchehab@kernel.org>,
        "randy dunlap" <rdunlap@infradead.org>,
        "jonathan corbet" <corbet@lwn.net>,
        "fabio m. de francesco" <fmdefrancesco@gmail.com>,
        "eric dumazet" <edumazet@google.com>,
        "christophe jaillet" <christophe.jaillet@wanadoo.fr>,
        "eric biggers" <ebiggers@kernel.org>,
        "keyrings" <keyrings@vger.kernel.org>,
        "linux-security-module" <linux-security-module@vger.kernel.org>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <185a186decb.743a09083686.6444154356172170497@siddh.me>
In-Reply-To: <2430913.1673452085@warthog.procyon.org.uk>
References: <1859d17668d.7b9d5469421579.5464668634216421773@siddh.me> <97ce37e2fdcfbed29d9467057f0f870359d88b89.1673173920.git.code@siddh.me> <cover.1673173920.git.code@siddh.me> <2121105.1673359772@warthog.procyon.org.uk> <2430913.1673452085@warthog.procyon.org.uk>
Subject: Re: [PATCH v3 1/2] include/linux/watch_queue: Improve documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 11 Jan 2023 21:18:05 +0530, David Howells wrote:
> Can you repost it without the first patch being present?

Sure.

Thanks,
Siddh 
 
