Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228164848AE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 20:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiADThI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 14:37:08 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:58576 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiADThH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 14:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=c79Cvyi3tuo9WddH41m2TtymOCs7U8J7heJs6dXudQ8=; b=svRBeHTRJns4oIluDmkept3Yev
        s/akUraqokxa/ewz2G5aFGKEiDr8OqfqBlal+izIZqK0AhsmdyedebCjeDq8OBCFyZROhaJM38ddG
        EJyGArTs9ncVcBhXLPcrdwbHrcrxZg5BU5N38fHtBOXQSD2W2LEsRoQnehteijDKUvcCSAESRFmWB
        I2iHNCGybG2RyINDFAsPUAChtXpdNoqZiKJzTbRK2z7MPp2OnRbJsKC+PC+lazkfHse/UFZ6HOxZw
        Ce9K2VxN/mUift8HTw9Qvdc9V0mC0XCqCZe0fGm12Q9kYylLU1gG4/rwy6lOdJFHyxV29MwBUsRz4
        QvoJn+BA==;
Received: from 200-153-146-242.dsl.telesp.net.br ([200.153.146.242] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n4pcB-000Bpn-3m; Tue, 04 Jan 2022 20:36:59 +0100
Subject: Re: pstore/ramoops - why only collect a partial dmesg?
To:     "Luck, Tony" <tony.luck@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
References: <a21201cf-1e5f-fed1-356d-42c83a66fa57@igalia.com>
 <2d1e9afa38474de6a8b1efc14925d095@intel.com>
 <0ca4c27a-a707-4d36-9689-b09ef715ac67@igalia.com>
 <a361c64213e7474ea39c97f7f7bd26ec@intel.com>
 <c5a04638-90c2-8ec0-4573-a0e5d2e24b6b@igalia.com>
 <8675f69c1643451b91f797b114dfc311@intel.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Message-ID: <b2d66d9f-15a6-415c-2485-44649027a1d5@igalia.com>
Date:   Tue, 4 Jan 2022 16:36:43 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8675f69c1643451b91f797b114dfc311@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/01/2022 15:46, Luck, Tony wrote:
> That does change things ... I wonder how many megabytes you need
> for a big system (hundreds of cores, thousands of tasks)!

Heheh indeed, this case would require a very big log buffer I guess! But
our setup is not so big, only 4/8 CPUs, not so much RAM and not that
many tasks expected, opposed to a big server with maybe multiple VMs,
containers, etc...

> 
> This use case does look like it could use multiple chunks in ramoops.

Cool, thanks! If nobody complains or show any reason in that ramoops
shouldn't be changed to deal with multi-chunk dmesg, I'll try to come up
with something then.

Cheers,


Guilherme
