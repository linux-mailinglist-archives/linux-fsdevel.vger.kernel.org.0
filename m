Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFA0C5E16F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 11:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfGCJxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 05:53:51 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:38337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfGCJxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:53:51 -0400
Received: from [192.168.1.110] ([95.114.150.241]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MYvPq-1i4UQO1u6a-00UvZs; Wed, 03 Jul 2019 11:53:48 +0200
Subject: Re: [PATCH] fs/seq_file: Replace a seq_printf() call by seq_puts() in
 seq_hex_dump()
To:     Markus Elfring <Markus.Elfring@web.de>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <8c295901-cdbd-a4a2-f23f-f63a58330f20@web.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <10744a9b-1c15-1581-8422-bbbf995c0da3@metux.net>
Date:   Wed, 3 Jul 2019 11:53:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8c295901-cdbd-a4a2-f23f-f63a58330f20@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xiC9aC0SXQUwA+BYVt/+cV5O9DXdVDss0yAIx+MA2irR0N/sKsm
 udBlm60BA5MbOe92vuTq4Qt3CHgj6T+u2bceMRInHA27d/jhvjAD3DeH5KutUKXwt+tLYep
 QdblIoLPF2rdW/drmNZeV+qy7YXWSajmZ8+rL8bQFq7VTL1W0abzuK0cij6Qf+XH1GEir40
 kyRDkF1zIp2Ne74uoBkOQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aPL7KJiS+uI=:7S7IBlN8EoVT6GT1IlIKwA
 o12t/oiXZ0KNqic8DlaUWj/Org71srYU03+4+GFF/dqevDPvGGbubRHtcE2+GdaxFotH6DUBm
 sftkTKR7YXHAyDLPAX5wUGQt9IQFXOIQ/8fwocN8i9cAeXDvuLZ1hgsLo0IR6lqKyAdUp83OD
 Gd+Skw2CG+VTgfg6EDktkIDczBP7hj5Rv0jGmdj95wteby4rUo4clq9o+6ZyO8DcJpAp+B9Of
 A+gXm8RyVlzBhYyzBScR6vFRaPjHIKso3LGWcY++CWFLq8SeKc8zFr5moGuSPDs5oWrXgZP8s
 /glNL1Ka+kTuqx9h297iRDHVHezCSUeDHyIBm3exgs8nTLpwI9s1e0aZOKO46BV21gbsGzye7
 hbOl5A+UQRjFcVADjfSTgccapUQ53DM5AlQJlxEnDrPC3MRChfLbMj5Slts54QLuy6BSqYS2m
 y002WGW5kHjCgpgomdSUkHczm3i79jIBpdbFkVhBhg+eR5kjOng7wiT9vdFScM2f31nACvBzT
 xDfQCbw6MXb+twLPqBD4f2viePHc/cGSPXzelRkrGg+aPftF86kiqWbJgIRmpEUnBPexdaaFq
 Fv3uzrlGtsLE9bagQqWa21/Xuijy4kEQymMphQFvC3dXIkUKq8sZa8ypopLl9R62/ge6davtZ
 D4QPyAIjqvowjJ26I7ngOIBwiH0SQZh5W/tvNhLES9yEItSOVPFaFuiRx+osA8gcLDVdw41Vs
 /JQ5f6OQovUAp9WNjXrf1IlnTneUvD45u2SA74H839mWdij/18A9yU1iozg=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.07.19 18:38, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 2 Jul 2019 18:28:10 +0200
> 
> A string which did not contain a data format specification should be put
> into a sequence. Thus use the corresponding function “seq_puts”.

Looks good, but have you checked whether "m" could ever be NULL and
whether seq_puts() has a check for that ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
