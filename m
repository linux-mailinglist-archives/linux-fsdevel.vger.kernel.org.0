Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1780446333
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 17:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfFNPpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 11:45:24 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33267 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfFNPpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:45:23 -0400
Received: from [192.168.1.110] ([77.4.92.40]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MD9nd-1hkMym2NO5-0098ca; Fri, 14 Jun 2019 17:45:21 +0200
Subject: Re: Help with reviewing dosfstools patches
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
        util-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190614102513.4uwsu2wkigg3pimq@pali>
 <ae5097ee-12af-2807-d48c-4274b4fc856d@metux.net>
Organization: metux IT consult
Message-ID: <9e81aa56-358a-71e1-edc1-50781062f3a4@metux.net>
Date:   Fri, 14 Jun 2019 17:45:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ae5097ee-12af-2807-d48c-4274b4fc856d@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qac5b9bV7zvSd7iQ4X0pCft/q2EJPLi7mfSiZbmTpE0sPDGhAC1
 VRNMAmKV36VozMyK3rWKT7sjIpddFXl8+8x2CHvrKhpMbxmYzvl1NoVwe571TmeQEecoPdd
 DovXLwbrtAq9WZLC19n+ZGnf3x/CaScxt6QLWiVlIAiPBzjVWmrfKAxWf0pmdnqSlv6YL4w
 6DvyI6Ff0MTUYJXdgdC8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wjdDE5rA/mI=:gEuP1f7JUa24CM5jb4oOe+
 sD2m3zN9pW1yiixDOZ+/BJ5JIiHUV92VLznT91iaUp9iTozKGSTvf33nVmAhwSUQUDNMFrLou
 1SKVnufEN40n5extwnYZ80cr1GG4JBZ4TD+ZwFFw0E7amq1OiGoQbV/aP/hFD0P7AvitkEwfK
 +XocfTWUMhz+pWh9taQMupi9XRo/vBiypNXHxw3FJUO0CEjUDUOrt/20l9D8z3fnhym/2cjRE
 QcUof+png9r7t2Hbc3J4IL+Jygn+oqmmG7thzGEA4KM7dymvY393GSPE9jvAXOcUMoGyqii6v
 zRnP7HEORP7tOFtgtz3Ubx2OAvAr8OXrDgUqmzB5iN4I40+rywJMzOpN4cA2y/DRtDEaYh/Y9
 DinhCpaBT9A4Q2gaj0D6IUFzBhs0IjJNzW1carOcebqe+u5GUyK4PnEYDT3U8Vekn4oauv+iH
 z+3qoV8hm7swc73sB7s+TmXbSDbAreprvWtGZNuFddY9wszKgoC1xbUPR9JeO6R1r4QGzSee4
 ucHRPC5pdAJSpd+bTB3g6shDdEH9MYuj+e8EwHK0s+cUMoEKPLKEDzZeUvT+zilPMfiU9qpCw
 B1kveLg4HX62JhFUcQhpFBMTvRzmsP6LLy8qQxJwjz+ZanHfCUx0t9lZzWQA3D025WBVjWB9I
 SjLhPmnFmQX9yZ6i24fwR354nhbPOguOXE3Gl2YVC268xO2zMaMRkiT4IuxOtUQB6l/4BWFBX
 vbTqY8ANnKyjH2TUx/IU3zaxRR3S9TYqDWTHGoPokFtgOCLZm9+dBJW/7M8=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.06.19 16:20, Enrico Weigelt, metux IT consult wrote:

<snip>

Currently working through your branches. Smells like they really deserve
a rebase and signed-off lines.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
