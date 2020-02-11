Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95529159998
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 20:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731598AbgBKTTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 14:19:04 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53102 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731591AbgBKTTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:19:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5D2E48EE148;
        Tue, 11 Feb 2020 11:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581448743;
        bh=BXU3TIG0j0QrJb5idUC/6y3sjEmyxsbL3NUmfSmqGgI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qwM6d5JTsKtlZ4lo3t97yVmlYcHSxFGhPwaP2uP07Yp36DmrXfUNyytT1BdCP0Z0e
         lA3YoOcxFeRd/U5+6f8lAHSSIln3i8PK42motZJq2bGR0ypuzFFvd5SmQNFsBDg1je
         Ge/4AQptXmp7BJjI6QO10WCFLgpl4XsAtfYaSqt0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EnRBXg5-50Hw; Tue, 11 Feb 2020 11:19:03 -0800 (PST)
Received: from [10.252.1.156] (unknown [198.134.98.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D24778EE0E0;
        Tue, 11 Feb 2020 11:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1581448743;
        bh=BXU3TIG0j0QrJb5idUC/6y3sjEmyxsbL3NUmfSmqGgI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qwM6d5JTsKtlZ4lo3t97yVmlYcHSxFGhPwaP2uP07Yp36DmrXfUNyytT1BdCP0Z0e
         lA3YoOcxFeRd/U5+6f8lAHSSIln3i8PK42motZJq2bGR0ypuzFFvd5SmQNFsBDg1je
         Ge/4AQptXmp7BJjI6QO10WCFLgpl4XsAtfYaSqt0=
Message-ID: <1581448739.3519.5.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] Multi-actuator HDDs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Keith Busch <kbusch@kernel.org>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, Tim Walker <tim.t.walker@seagate.com>
Date:   Tue, 11 Feb 2020 11:18:59 -0800
In-Reply-To: <20200210182645.GA2535@dhcp-10-100-145-180.wdl.wdc.com>
References: <CAPNbX4RxaZLi9F=ShVb85GZo_nMFaMhMuqhK50d5CLaarVDCeg@mail.gmail.com>
         <20200210182645.GA2535@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-02-10 at 10:26 -0800, Keith Busch wrote:
> On Mon, Feb 10, 2020 at 12:01:13PM -0600, Muhammad Ahmad wrote:
> > For NVMe HDDs are namespaces the appropriate abstraction of the
> > multiple actuators?
> 
> This sounds closer to what "NVM Sets" defines rather than namespaces.
> Section 4.9 from NVMe 1.4 spec has additional details if interested.

I've got to say that since multi-actuator devices will always be
spinning rust, bending NVMe concepts to fit them seems horribly wrong
... as does adding any rotational devices to NVMe: You just built a
clean NVM stack ... let's not contaminate it.

James

