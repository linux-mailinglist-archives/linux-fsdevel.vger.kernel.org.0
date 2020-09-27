Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D879127A251
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Sep 2020 20:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgI0SZ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Sep 2020 14:25:28 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54770 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgI0SZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Sep 2020 14:25:28 -0400
Received: from [192.168.254.38] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8DA9420B7178;
        Sun, 27 Sep 2020 11:25:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8DA9420B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601231127;
        bh=NZJ93BWQdNdtnup4P68DjyJ2f4J6Q7RZaGDO8Xn2+3I=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=DpS0rOFX9c2GsPc1PEXzlWFOu+1KBs4zeUS1aH7fAkW2jf062lNBLwoWEkVn5uF63
         pmFvWTR0KD5a1Tp6TJYLSMtw+URTbe8DcbBwZSJ/h6Z6gwbOHMPn/CL/wf/tULcEjl
         e/MX1aKmZY/E641oQi2DMMrk1AYIHKfwxVOEDCe0=
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, libffi-discuss@sourceware.org, luto@kernel.org,
        David.Laight@ACULAB.COM, mark.rutland@arm.com, mic@digikod.net,
        pavel@ucw.cz
References: <20200916150826.5990-1-madvenka@linux.microsoft.com>
 <87v9gdz01h.fsf@mid.deneb.enyo.de>
 <96ea02df-4154-5888-1669-f3beeed60b33@linux.microsoft.com>
 <20200923014616.GA1216401@rani.riverdale.lan>
 <20200923091125.GB1240819@rani.riverdale.lan>
 <a742b9cd-4ffb-60e0-63b8-894800009700@linux.microsoft.com>
 <20200923195147.GA1358246@rani.riverdale.lan>
 <2ed2becd-49b5-7e76-9836-6a43707f539f@linux.microsoft.com>
 <87o8luvqw9.fsf@mid.deneb.enyo.de>
 <3fe7ba84-b719-b44d-da87-6eda60543118@linux.microsoft.com>
Message-ID: <fdfe73d3-d735-4bdc-4790-7feb7fecece5@linux.microsoft.com>
Date:   Sun, 27 Sep 2020 13:25:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3fe7ba84-b719-b44d-da87-6eda60543118@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before I implement the user land solution recommended by reviewers, I just want
an opinion on where the code should reside.

I am thinking glibc. The other choice would be a separate library, say, libtramp.
What do you recommend?

Madhavan
