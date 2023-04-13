Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D916E142A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjDMS3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 14:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMS3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:29:00 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59D32D53;
        Thu, 13 Apr 2023 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1681410534;
        bh=jGwzJw7lP3rN+v/QJE3PZ7uZA3cqTAeu5GAX2Ol/eZo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=pPwCr6Zwizp1/IBcIS46B4wxR53W8xzNoCq9q78eSRfTQaFP3DnEAVdNoOR7AUYAm
         YA0591+re/X63z4hNO8YGCxb3KYegETQV6NepwrfwXT06e2cmix3W0jsMN02/olC5d
         VD2oIVxEVNv1jqExdSBPtR/0FKKXEJuagOM1bzZ0=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D1BB312868DC;
        Thu, 13 Apr 2023 14:28:54 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id AgN11Pc04sy7; Thu, 13 Apr 2023 14:28:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1681410534;
        bh=jGwzJw7lP3rN+v/QJE3PZ7uZA3cqTAeu5GAX2Ol/eZo=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=pPwCr6Zwizp1/IBcIS46B4wxR53W8xzNoCq9q78eSRfTQaFP3DnEAVdNoOR7AUYAm
         YA0591+re/X63z4hNO8YGCxb3KYegETQV6NepwrfwXT06e2cmix3W0jsMN02/olC5d
         VD2oIVxEVNv1jqExdSBPtR/0FKKXEJuagOM1bzZ0=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AFF31128666D;
        Thu, 13 Apr 2023 14:28:53 -0400 (EDT)
Message-ID: <726533b0e5f511678e4f40a768974fa818e9677f.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF] Running BOF
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Date:   Thu, 13 Apr 2023 14:28:52 -0400
In-Reply-To: <ZALROVnC+GDXsBne@casper.infradead.org>
References: <ZALROVnC+GDXsBne@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2023-03-04 at 05:03 +0000, Matthew Wilcox wrote:
> Sunday May 7th is the Vancouver Marathon, and both Josef and I are
> registered.  As such, neither of us may be feeling much like joining
> or leading a run.  If anyone else is interested in participating,
> https://bmovanmarathon.ca/ offers 8km and 21.1km races as well.  If
> you just want a spot of morning exercise, I can suggest routes, but
> will probably not join you.

For those of you who fancy something more scenic and less damaging to
the knees, Mike and I were planning a hike around the chain lakes trail
by Mt Baker:

https://www.fs.usda.gov/recarea/mbs/recarea/?recid=80181

As long as there's been no recent snowfall, both the trail and the
Bagley Lakes trailhead should be accessible.  The Rangers have been
known to keep Chain Lakes closed until June, so we might have to go
along one of the other trails instead.

Mike and I are planning to drive up early on Sunday from Seattle, but
it is possible to drive from Vancouver as well if you have a car
(There's a US$5/car charge at the car park).

Regards,

James

